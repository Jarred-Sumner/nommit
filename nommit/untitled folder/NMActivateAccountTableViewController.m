//
//  NMActivateAccountTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMActivateAccountTableViewController.h"
#import "NMAccountInformationTableViewCell.h"
#import "NMTableSeparatorView.h"
#import "NMActivatePhoneTableViewCell.h"
#import "NMPaymentInfoTableViewCell.h"
#import "PTKView.h"
#import "NMColors.h"
#import "Stripe.h"
#import "SVProgressHUD.h"
#import "NMNavigationController.h"
#import "NMFoodsTableViewController.h"
#import "NMConstants.h"
#import <SIAlertView/SIAlertView.h>
#import "NMConfirmNumberViewController.h"


@interface NMActivateAccountTableViewController ()<PTKViewDelegate>

@property (nonatomic, strong) NMAccountInformationTableViewCell *infoCell;
@property (nonatomic, strong) NMPaymentInfoTableViewCell *paymentCell;
@property (nonatomic, strong) NMActivatePhoneTableViewCell *phoneCell;
@property (nonatomic, strong) UIBarButtonItem *saveButton;

@end

@implementation NMActivateAccountTableViewController

const NSInteger NMAccountInfoSection = 0;
const NSInteger NMActivatePhoneSection = 1;

static NSString *NMAccountInfoTableViewCellKey = @"NMAcountInfoTableViewCell";
static NSString *NMRegisterPhoneTableViewCellKey = @"NMRegisterPhoneTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.clearsSelectionOnViewWillAppear = NO;

        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMAccountInformationTableViewCell class] forCellReuseIdentifier:NMAccountInfoTableViewCellKey];
        [self.tableView registerClass:[NMActivatePhoneTableViewCell class] forCellReuseIdentifier:NMRegisterPhoneTableViewCellKey];

        self.navigationItem.hidesBackButton = YES;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.title = @"Register Account";
    
    [self initNavBar];
    
    NMNavigationController *navController = (NMNavigationController *)self.navigationController;
    navController.frostedViewController.panGestureEnabled = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[Mixpanel sharedInstance] track:@"Show Activate Account Page"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMTableSeparatorView *separatorView = [[NMTableSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 273, 17)];
    if (section == NMAccountInfoSection) {
        separatorView.sectionLabel.text = @"ACCOUNT INFORMATION";
    } else if (section == NMActivatePhoneSection) {
        separatorView.sectionLabel.text = @"ENTER PHONE NUMBER";
    }
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAccountInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMAccountInfoTableViewCellKey];
        _infoCell.avatar.profileID = NMUser.currentUser.facebookUID;
        _infoCell.nameLabel.text = NMUser.currentUser.fullName;
        _infoCell.emailLabel.text = NMUser.currentUser.email;
        return _infoCell;
    } else if (indexPath.section == NMActivatePhoneSection) {
        _phoneCell = [self.tableView dequeueReusableCellWithIdentifier:NMRegisterPhoneTableViewCellKey];
        [_phoneCell.textField becomeFirstResponder];
        return _phoneCell;
    }
    return nil;
}

#pragma mark - nav bar

- (void)initNavBar {
    // Setup save button
    _saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(next)];
    self.navigationItem.rightBarButtonItem = _saveButton;
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)next {
    __block NMActivateAccountTableViewController *this = self;
    
    [SVProgressHUD showWithStatus:@"Saving..." maskType:SVProgressHUDMaskTypeBlack];
    [[NMApi instance] PUT:[NSString stringWithFormat:@"users/%@", [[NMUser currentUser] facebookUID]] parameters:@{ @"phone" : _phoneCell.textField.text } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"Saved!"];
            NMConfirmNumberViewController *vc = [[NMConfirmNumberViewController alloc] init];
            [this.navigationController pushViewController:vc animated:YES];
        }

    }];

    
}

@end
