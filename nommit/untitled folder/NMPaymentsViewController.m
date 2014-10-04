//
//  NMPaymentsViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/8/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPaymentsViewController.h"
#import "PTKView.h"
#import "NMColors.h"
#import "Stripe.h"
#import "SVProgressHUD.h"
#import "NMMenuNavigationController.h"
#import "NMFoodsTableViewController.h"
#import <SIAlertView/SIAlertView.h>

#define PDefaultBoldFont [UIFont boldSystemFontOfSize:17]
static NSString *hiddenCardNums = @"XXXX-XXXX-XXXX-";

@interface NMPaymentsViewController ()<PTKViewDelegate>

@property (nonatomic, strong) PTKView *paymentView;
@property (nonatomic, strong) UILabel *hiddenCardLabel;
@property (nonatomic, strong) UIButton *hiddenCardButton;

@end

@implementation NMPaymentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Payment Information";
    self.view.backgroundColor = [NMColors lightGray];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    // setup cancel button
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                style:UIBarButtonItemStylePlain
               target:(NMMenuNavigationController *)self.navigationController
               action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Setup checkout
    _paymentView = [[PTKView alloc] initWithFrame:CGRectMake(24, 20, 300, 55)];
    _paymentView.delegate = self;
    [self.view addSubview:_paymentView];
    
    // Setup editable checkout
    _hiddenCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 22, 238, 38)];
    _hiddenCardLabel.backgroundColor = UIColorFromRGB(0xf7f7f7);
    _hiddenCardLabel.text = [NSString stringWithFormat:@"%@4242", hiddenCardNums];
    _hiddenCardLabel.textColor = UIColorFromRGB(0xcecece);
    _hiddenCardLabel.font = PDefaultBoldFont;
    _hiddenCardLabel.layer.cornerRadius = 10;
    _hiddenCardLabel.layer.masksToBounds = YES;
    
    [self.view addSubview:_hiddenCardLabel];
    
    _hiddenCardButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    _hiddenCardButton.backgroundColor = [UIColor clearColor];
    [_hiddenCardButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_hiddenCardButton];
    
    _hiddenCardLabel.hidden = YES;
    _hiddenCardButton.hidden = YES;
    _paymentView.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [NMColors mainColor]};
}

- (void)paymentView:(PTKView *)paymentView
           withCard:(PTKCard *)card
            isValid:(BOOL)valid {
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (void)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)edit:(id)sender {
    _paymentView.hidden = NO;
    _hiddenCardButton.hidden = YES;
    _hiddenCardLabel.hidden = YES;
}

- (IBAction)save:(id)sender {
    if (_paymentView.hidden == YES) {
        [SVProgressHUD showWithStatus:@"Validating..." maskType:SVProgressHUDMaskTypeBlack];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (![_paymentView isValid]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"Please re-enter it and try again"];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
        return;
    }
    [Stripe setDefaultPublishableKey:STRIPE_KEY];
    
    [SVProgressHUD showWithStatus:@"Saving..." maskType:SVProgressHUDMaskTypeBlack];
    
    STPCard *card = [[STPCard alloc] init];
    card.number = _paymentView.card.number;
    card.expMonth = _paymentView.card.expMonth;
    card.expYear = _paymentView.card.expYear;
    card.cvc = _paymentView.card.cvc;
    
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        
        if (error) {
            [SVProgressHUD dismiss];
            SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Error while saving card" andMessage:@"Please re-enter it and try again"];
            [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
            [alert show];
        } else {
            NSDictionary *params = @{ @"stripe_token" : token.tokenId };
            
            NSString *path = [NSString stringWithFormat:@"users/%@", NMUser.currentUser.facebookUID];
            
            [[NMApi instance] PUT:path parameters:params completion:^(OVCResponse *response, NSError *error) {
                if ([response.result class] == [NMErrorApiModel class]) {
                    [response.result handleError];
                } else if (error) {
                    [NMErrorApiModel handleGenericError];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"Saved!"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }];
            
            
        }
    }];
}


@end
