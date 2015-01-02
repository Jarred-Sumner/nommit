//
//  NMPaymentsViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/8/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMPaymentsViewController.h"
#import "PTKView.h"
#import "NMColors.h"
#import "Stripe.h"
#import "SVProgressHUD.h"
#import "NMNavigationController.h"
#import "NMFoodsTableViewController.h"
#import <SIAlertView/SIAlertView.h>
#import "NMTableSeparatorView.h"
#import "NMPaymentInfoTableViewCell.h"

@interface NMPaymentsViewController ()<PTKViewDelegate>

@property (nonatomic, strong) NMPaymentInfoTableViewCell *paymentCell;
@property (nonatomic, copy) NMCompletionBlock completionBlock;

@end

@implementation NMPaymentsViewController

static NSString *NMPaymentCellIdentifier = @"NMPaymentCellIdentifier";

- (instancetype)initWithCompletionBlock:(NMCompletionBlock)completionBlock {
    self = [self initWithStyle:UITableViewStylePlain];
    _completionBlock = completionBlock;
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.title = @"Payment Information";
    self.view.backgroundColor = [NMColors lightGray];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [self.tableView registerClass:[NMPaymentInfoTableViewCell class] forCellReuseIdentifier:NMPaymentCellIdentifier];
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : [NMColors mainColor]
    };
    
    [[Mixpanel sharedInstance] track:@"Show Payments Page"];
}


#pragma mark - Data Source



- (UIView*)tableView:tableView viewForHeaderInSection:(NSInteger)section {
    NMTableSeparatorView *separatorView = [[NMTableSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 273, 17)];

    if (section == 0) {
        separatorView.sectionLabel.text = @"ENTER PAYMENT INFORMATION";
    }
    
    return separatorView;
}

- (NSInteger)tableView:tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _paymentCell = [self.tableView dequeueReusableCellWithIdentifier:NMPaymentCellIdentifier];
    _paymentCell.paymentView.delegate = self;
    return _paymentCell;
}

- (void)save {
    if (_paymentCell.paymentView.hidden == YES) {
        [SVProgressHUD showWithStatus:@"Validating..." maskType:SVProgressHUDMaskTypeBlack];
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (![_paymentCell.paymentView isValid]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"" andMessage:@"Please re-enter it and try again"];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
        return;
    }
    [Stripe setDefaultPublishableKey:STRIPE_KEY];
    
    [SVProgressHUD showWithStatus:@"Saving..." maskType:SVProgressHUDMaskTypeBlack];
    
    STPCard *card = [[STPCard alloc] init];
    card.number = _paymentCell.paymentView.card.number;
    card.expMonth = _paymentCell.paymentView.card.expMonth;
    card.expYear = _paymentCell.paymentView.card.expYear;
    card.cvc = _paymentCell.paymentView.card.cvc;
    
    __block NMPaymentsViewController *this = self;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        
        if (error) {
            [SVProgressHUD dismiss];
            SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Error while saving card" andMessage:@"Please re-enter it and try again"];
            [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
            [alert show];
        } else {
            NSDictionary *params = @{ @"stripe_token" : token.tokenId };
            
            NSString *path = [NSString stringWithFormat:@"users/%@", NMUser.currentUser.facebookUID];
            
            [[NMApi instance] PUT:path parameters:params completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
                [this didSaveSuccessfullyWithToken:token card:card];
            }];
        }
        
    }];
    
}

- (void)didSaveSuccessfullyWithToken:(STPToken*)token card:(STPCard*)card {
    _paymentCell.sCard = [card.number substringFromIndex:[card.number length] - 4] ;
    _paymentCell.sToken = token;
    
    _paymentCell.hiddenCardLabel.text = [NSString stringWithFormat:@"%@%@", hiddenCardNums, _paymentCell.sCard];
    _paymentCell.hiddenCardLabel.hidden = NO;
    
    [SVProgressHUD showSuccessWithStatus:@"Saved!"];
    self.completionBlock();
}



@end
