//
//  NMVerifyPhoneNumberViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMConfirmNumberViewController.h"
#import "NMTableSeparatorView.h"
#import "NMFoodsTableViewController.h"
#import <SIAlertView.h>
#import "NMNavigationController.h"
#import "NMPaymentsViewController.h"

@interface NMConfirmNumberViewController ()

@property (nonatomic, strong) NMConfirmPhoneTableViewCell *confirmPhoneTableViewCell;

@end

@implementation NMConfirmNumberViewController

static NSString *NMConfirmNumberTableViewCellKey = @"NMConfirmNumberTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        [(NMNavigationController*)self.navigationController setDisabledMenu:YES];
        
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMConfirmPhoneTableViewCell class] forCellReuseIdentifier:NMConfirmNumberTableViewCellKey];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Confirm Phone";
    // Do any additional setup after loading the view.
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Confirm Phone Number" andMessage:@"You've been texted a four digit confirm code. Please enter it to get started ordering food with Nommit."];
    [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
    [alert show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NMNavigationController *navController = (NMNavigationController *)self.navigationController;
    navController.frostedViewController.panGestureEnabled = NO;
    [[Mixpanel sharedInstance] track:@"Showed Confirm Phone Number Page"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMTableSeparatorView *separatorView = [[NMTableSeparatorView alloc] initWithFrame:CGRectMake(0, 0, 273, 17)];
    separatorView.sectionLabel.text = @"Confirm Code";
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _confirmPhoneTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:NMConfirmNumberTableViewCellKey];
    [_confirmPhoneTableViewCell.textField addTarget:self action:@selector(confirmTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_confirmPhoneTableViewCell.textField becomeFirstResponder];
    return _confirmPhoneTableViewCell;
}

#pragma mark - NMConfirmNumberDelegate

- (BOOL)confirmTextDidChange:(id)sender
{
    self.navigationItem.rightBarButtonItem.enabled = [sender text].length == 4;
    return YES;
}

- (void)done:(id)button
{
    __block NMConfirmNumberViewController *this = self;
    [SVProgressHUD showWithStatus:@"Verifying..." maskType:SVProgressHUDMaskTypeBlack];
    NSString *path = [NSString stringWithFormat:@"users/%@", NMUser.currentUser.facebookUID];
    
    [[NMApi instance] PUT:path parameters:@{ @"confirm_code" : _confirmPhoneTableViewCell.textField.text } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        
        [SVProgressHUD showSuccessWithStatus:@"Verified!"];
        NMPaymentsViewController *payVC = [[NMPaymentsViewController alloc] initWithCompletionBlock:^{
            [NMPlace refreshAllWithCompletion:^(id response, NSError *error) {

                NMFoodsTableViewController *foodsVC = [[NMFoodsTableViewController alloc] initWithPlace:nil];
                [this.navigationController pushViewController:foodsVC animated:YES];
                [[Mixpanel sharedInstance] track:@"Ended Activation Flow"];
            }];
            
            
        }];
        
        [this.navigationController pushViewController:payVC animated:YES];

    }];
    
   
}


@end
