//
//  NMVerifyPhoneNumberViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMVerifyPhoneNumberViewController.h"
#import "NMTableSeparatorView.h"

@interface NMVerifyPhoneNumberViewController ()

@property (nonatomic, strong) NMVerifyPhoneNumerTableViewCell *verifyPhoneNumberTableViewCell;

@end

@implementation NMVerifyPhoneNumberViewController

static NSString *NMVerifyPhoneNumberTableViewCellKey = @"NMVerifyPhoneNumberTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.tableView registerClass:[NMVerifyPhoneNumerTableViewCell class] forCellReuseIdentifier:NMVerifyPhoneNumberTableViewCellKey];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Setup save button
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    saveButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    separatorView.sectionLabel.text = @"Verify Phone Number";
    return separatorView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _verifyPhoneNumberTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:NMVerifyPhoneNumberTableViewCellKey];
    _verifyPhoneNumberTableViewCell.delegate = self;
    return _verifyPhoneNumberTableViewCell;
}

- (void)verifyCodeFormat
{
    if ([_verifyPhoneNumberTableViewCell.textField.text length] == 4) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)done:(id)button
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
