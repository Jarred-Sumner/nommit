//
//  NMActivateAccountTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMActivateAccountTableViewController.h"
#import "NMAccountInformationTableViewCell.h"
#import "NMTableSeparatorView.h"
#import "NMActivatePhoneTableViewCell.h"
#import "NMActivatePaymentTableViewCell.h"
#import "PTKView.h"
#import "NMColors.h"
#import "Stripe.h"
#import "SVProgressHUD.h"
#import "NMMenuNavigationController.h"
#import "NMFoodsTableViewController.h"
#import "NMConstants.h"
#import <SIAlertView/SIAlertView.h>
#import "NMConfirmNumberViewController.h"


@interface NMActivateAccountTableViewController ()<PTKViewDelegate>

@property (nonatomic, strong) NMAccountInformationTableViewCell *infoCell;
@property (nonatomic, strong) NMActivatePaymentTableViewCell *paymentCell;
@property (nonatomic, strong) NMActivatePhoneTableViewCell *phoneCell;
@property (nonatomic, strong) UIBarButtonItem *saveButton;

@end

@implementation NMActivateAccountTableViewController

const NSInteger NMAccountInfoSection = 0;
const NSInteger NMActivatePaymentSection = 1;
const NSInteger NMActivatePhoneSection = 2;

static NSString *NMAccountInfoTableViewCellKey = @"NMAcountInfoTableViewCell";
static NSString *NMRegisterPaymentTableViewCellKey = @"NMRegisterPaymentTableViewCell";
static NSString *NMRegisterPhoneTableViewCellKey = @"NMRegisterPhoneTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {

        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMAccountInformationTableViewCell class] forCellReuseIdentifier:NMAccountInfoTableViewCellKey];
        [self.tableView registerClass:[NMActivatePhoneTableViewCell class] forCellReuseIdentifier:NMRegisterPhoneTableViewCellKey];
        [self.tableView registerClass:[NMActivatePaymentTableViewCell class] forCellReuseIdentifier:NMRegisterPaymentTableViewCellKey];

    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Register Account";
    [self checkPhoneValid];
    
    [self initNavBar];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInfoSection) {
        return 76;
    }
    return 70;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMTableSeparatorView *separatorView = [[NMTableSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 273, 17)];
    if (section == NMAccountInfoSection) {
        separatorView.sectionLabel.text = @"ACCOUNT INFORMATION";
    } else if (section == NMActivatePhoneSection) {
        separatorView.sectionLabel.text = @"ENTER PHONE NUMBER";
    } else if (section == NMActivatePaymentSection) {
        separatorView.sectionLabel.text = @"ENTER PAYMENT INFORMATION";
    }
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountInfoTableViewCellKey];
        
        _infoCell.nameLabel.text = NMUser.currentUser.fullName;
        _infoCell.emailLabel.text = NMUser.currentUser.email;
        return _infoCell;
    } else if (indexPath.section == NMActivatePhoneSection) {
        _phoneCell = [self.tableView dequeueReusableCellWithIdentifier:NMRegisterPhoneTableViewCellKey];
        _phoneCell.delegate = self;
        return _phoneCell;
    } else if (indexPath.section == NMActivatePaymentSection) {
        _paymentCell = [self.tableView dequeueReusableCellWithIdentifier:NMRegisterPaymentTableViewCellKey];
        _paymentCell.paymentView.delegate = self;
        return _paymentCell;
    }
    return nil;
}

#pragma mark - nav bar

- (void)initNavBar {
    // Setup save button
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(save:)];
    _saveButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = _saveButton;
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - payments information

- (void)paymentView:(PTKView *)paymentView
           withCard:(PTKCard *)card
            isValid:(BOOL)valid {
    // Enable save button if the Checkout is valid
    if ([_phoneCell.textField.text length] > 0) {
        _saveButton.enabled = valid;
    }
}

- (IBAction)save:(id)sender {
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
    
    __block NMActivateAccountTableViewController *this = self;
    [Stripe createTokenWithCard:card completion:^(STPToken *token, NSError *error) {
        
        if (error) {
            [SVProgressHUD dismiss];
            SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Error while saving card" andMessage:@"Please re-enter it and try again"];
            [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
            [alert show];
        } else {
            NSDictionary *params = @{ @"stripe_token" : token.tokenId, @"phone" : _phoneCell.textField.text };
            
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
    NMConfirmNumberViewController *phoneVC = [[NMConfirmNumberViewController alloc] init];
    [self.navigationController pushViewController:phoneVC animated:YES];
}

#pragma mark - NMRegisterPhoneTableViewCellDelegate methods

- (void)checkPhoneValid
{
    if ([_phoneCell.textField.text length] > 0) {
        [self paymentView:_paymentCell.paymentView withCard:_paymentCell.paymentView.card isValid:_paymentCell.paymentView.isValid];
    }
}

@end
