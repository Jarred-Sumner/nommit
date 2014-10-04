//
//  NMVerifyPhoneNumberViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMVerifyPhoneNumberViewController.h"
#import "NMTableSeparatorView.h"
#import "NMFoodsTableViewController.h"
#import <SIAlertView.h>

@interface NMVerifyPhoneNumberViewController ()

@property (nonatomic, strong) NMVerifyPhoneNumberTableViewCell *verifyPhoneNumberTableViewCell;

@end

@implementation NMVerifyPhoneNumberViewController

static NSString *NMVerifyPhoneNumberTableViewCellKey = @"NMVerifyPhoneNumberTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMVerifyPhoneNumberTableViewCell class] forCellReuseIdentifier:NMVerifyPhoneNumberTableViewCellKey];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Confirm Phone";
    // Do any additional setup after loading the view.
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
    
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Confirm Phone Number" andMessage:@"You've been texted a six digit confirm code. Please enter it to get started ordering food with Nommit."];
    [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
    [alert show];
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
    _verifyPhoneNumberTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:NMVerifyPhoneNumberTableViewCellKey];
    _verifyPhoneNumberTableViewCell.delegate = self;
    [_verifyPhoneNumberTableViewCell.textField becomeFirstResponder];
    return _verifyPhoneNumberTableViewCell;
}

- (void)verifyCodeFormat
{
    if ([_verifyPhoneNumberTableViewCell.textField.text length] == 6) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)done:(id)button
{
    [SVProgressHUD showWithStatus:@"Verifying..." maskType:SVProgressHUDMaskTypeBlack];
    NSString *path = [NSString stringWithFormat:@"users/%@", NMUser.currentUser.facebookUID];
    
    [[NMApi instance] PUT:path parameters:@{ @"confirm_code" : _verifyPhoneNumberTableViewCell.textField.text } completion:^(OVCResponse *response, NSError *error) {
        if ([response.result class] == [NMErrorApiModel class]) {
            [response.result handleError];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"Verified!"];
            NMFoodsTableViewController *ftv = [[NMFoodsTableViewController alloc] init];
            [self.navigationController pushViewController:ftv animated:YES];
        }
    }];
    
   
}


@end
