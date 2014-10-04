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

#define PDefaultBoldFont [UIFont boldSystemFontOfSize:17]
static NSString *hiddenCardNums = @"XXXX-XXXX-XXXX-";

@interface NMPaymentsViewController ()<PTKViewDelegate> {
    UILabel *hiddenCardLabel;
    UIButton *hiddenCardButton;
    STPToken *sToken;
    NSString *sCard;
}
@property(weak, nonatomic) PTKView *paymentView;
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
    PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(24, 20, 300, 55)];
    paymentView.delegate = self;
    self.paymentView = paymentView;
    [self.view addSubview:paymentView];
    
    // Setup editable checkout
    hiddenCardLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 22, 238, 38)];
    hiddenCardLabel.backgroundColor = UIColorFromRGB(0xf7f7f7);
    hiddenCardLabel.text = [NSString stringWithFormat:@"%@4242", hiddenCardNums];
    hiddenCardLabel.textColor = UIColorFromRGB(0xcecece);
    hiddenCardLabel.font = PDefaultBoldFont;
    hiddenCardLabel.layer.cornerRadius = 10;
    hiddenCardLabel.layer.masksToBounds = YES;
    
    [self.view addSubview:hiddenCardLabel];
    hiddenCardButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 290, 55)];
    hiddenCardButton.backgroundColor = [UIColor clearColor];
    [hiddenCardButton addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:hiddenCardButton];
    
    // NSString *sTokenId = [[PFUser currentUser] objectForKey:@"sToken"];
    NSString *sTokenId = @"";
    if (sTokenId) {
//        [Stripe requestTokenWithID:[[PFUser currentUser] objectForKey:@"sToken"] completion:^(STPToken *token, NSError *error) {
//            
//            if (!error) {
//                sToken = token;
//                sCard = [[PFUser currentUser] objectForKey:@"sCard"];
//                hiddenCardLabel.text = [NSString stringWithFormat:@"%@%@", hiddenCardNums, sCard];
//                hiddenCardLabel.hidden = NO;
//                hiddenCardButton.hidden = NO;
//            } else {
//                sCard = @"4242";
//                hiddenCardLabel.hidden = YES;
//                hiddenCardButton.hidden = YES;
//                self.paymentView.hidden = NO;
//            }
//        }];
        sCard = @"4242";
        hiddenCardLabel.hidden = YES;
        hiddenCardButton.hidden = YES;
        self.paymentView.hidden = NO;

        
    } else {
        sCard = @"4242";
        hiddenCardLabel.hidden = YES;
        hiddenCardButton.hidden = YES;
        self.paymentView.hidden = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [NMColors mainColor]};
}

- (void)paymentView:(PTKView *)paymentView
           withCard:(PTKCard *)card
            isValid:(BOOL)valid {
    // Enable save button if the Checkout is valid
    self.navigationItem.rightBarButtonItem.enabled = valid;
}

- (void)cancel:(id)sender {
    NMFoodsTableViewController *mainVC = [[NMFoodsTableViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
}

- (void)edit:(id)sender {
    NSLog(@"editing now");
    self.paymentView.hidden = NO;
    hiddenCardButton.hidden = YES;
    hiddenCardLabel.hidden = YES;
}

- (IBAction)save:(id)sender {
    if (self.paymentView.hidden == YES) {
        [SVProgressHUD showWithStatus:@"Verifying..."];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (![self.paymentView isValid]) {
        [SVProgressHUD showErrorWithStatus:@"Invalid Credit Card! Please re-enter it and try again"];
        return;
    }
    [SVProgressHUD showWithStatus:@"Verified. Updating!"];
    STPCard *card = [[STPCard alloc] init];
    card.number = self.paymentView.card.number;
    card.expMonth = self.paymentView.card.expMonth;
    card.expYear = self.paymentView.card.expYear;
    card.cvc = self.paymentView.card.cvc;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"Updated!"];
        if (error) {
            [self hasError:error];
        } else {
            sCard = [card.number substringFromIndex:[card.number length] - 4] ;
            sToken = token;
            hiddenCardLabel.text = [NSString stringWithFormat:@"%@%@", hiddenCardNums, sCard];
            hiddenCardLabel.hidden = NO;
            hiddenCardButton.hidden = NO;
            [self hasToken:token];
        }
    }];
}

- (void)hasError:(NSError *)error {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error")
                                                      message:[error localizedDescription]
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                            otherButtonTitles:nil];
    [message show];
}

- (void)hasToken:(STPToken *)token
{
    [SVProgressHUD showSuccessWithStatus:@"Updated!"];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NMFoodsTableViewController *mainVC = [[NMFoodsTableViewController alloc] init];
    [self.navigationController pushViewController:mainVC animated:YES];
        return;
    
}

@end
