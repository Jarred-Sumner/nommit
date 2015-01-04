//
//  NMBecomeASellerTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 1/1/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMBecomeASellerTableViewController.h"
#import "NMBecomeASellerBannerTableViewCell.h"
#import "NMBecomeASellerInfoTableViewCell.h"
#import "NMBecomeASellerApplyView.h"


const NSInteger NMBecomeASellerBannerSection = 0;
const NSInteger NMBecomeASellerInfoSection = 1;

static NSString *NMBecomeASellerBannerIdentifier = @"NMBecomeASellerBannerCell";
static NSString *NMBecomeASellerInfoIdentifier = @"NMBecomeASellerInfoCell";
static NSString *NMBecomeASellerApplyIdentifier = @"NMBecomeASellerApplyCell";

@interface NMBecomeASellerTableViewController ()

@property (nonatomic, strong) NMBecomeASellerBannerTableViewCell *bannerCell;
@property (nonatomic, strong) NMBecomeASellerInfoTableViewCell *infoCell;

@end

@implementation NMBecomeASellerTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.backgroundColor = UIColorFromRGB(0xF3F1F1);
        [self.tableView registerClass:[NMBecomeASellerBannerTableViewCell class] forCellReuseIdentifier:NMBecomeASellerBannerIdentifier];
        [self.tableView registerClass:[NMBecomeASellerInfoTableViewCell class] forCellReuseIdentifier:NMBecomeASellerInfoIdentifier];
        [self.tableView registerClass:[NMBecomeASellerApplyView class] forHeaderFooterViewReuseIdentifier:NMBecomeASellerApplyIdentifier];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self initNavBar];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Become A Seller";
}

- (void)initNavBar {
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(UINavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    lbb.imageInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    if (!self.navigationItem.leftBarButtonItem) self.navigationItem.leftBarButtonItem = lbb;
    
    self.navigationController.navigationBarHidden = NO;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMBecomeASellerBannerSection) {
        return 84;
    } else if (indexPath.section == NMBecomeASellerInfoSection) {
        return 423;
    } return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == NMBecomeASellerInfoSection) {
        return 132.0f;
    } else return 0.f;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NMBecomeASellerApplyView *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:NMBecomeASellerApplyIdentifier];
    
    [view.applyButton addTarget:self action:@selector(applyToBeSeller) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMBecomeASellerBannerSection) {
        _bannerCell = [self.tableView dequeueReusableCellWithIdentifier:NMBecomeASellerBannerIdentifier];
        _bannerCell.bannerLabel.text = @"Make from $15/hour to over $150/hour selling food people want.";
        return _bannerCell;
    } else if (indexPath.section == NMBecomeASellerInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMBecomeASellerInfoIdentifier];

        _infoCell.getFoodTitle.text = @"Get Food";
        _infoCell.chefTitle.text = @"Prepare Food";
        _infoCell.peopleTitle.text = @"Deliver Food";
        _infoCell.dollarTitle.text = @"Profit";
        
        _infoCell.getFoodDesc.text = @"Buy fresh food people want from restaurants and grocery stores.";
        _infoCell.chefDesc.text = @"Heat, box, package, and bag the food before deliveries start.";
        _infoCell.peopleDesc.text = @"Gather 3-4 friends and deliver the food together!";
        _infoCell.dollarDesc.text = @"Mark up the price and sell!";
        
        return _infoCell;
    }
    return nil;
}

- (void)applyToBeSeller {
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Are you sure?" andMessage:@"Upon confirmation, we'll contact you by email or phone in the next 48 hours"];
    [alert addButtonWithTitle:@"Cancel" type:SIAlertViewButtonTypeCancel handler:NULL];
    [alert addButtonWithTitle:@"Confirm" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {

        [[NMApi instance] POST:@"sellers" parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showSuccessWithStatus:@"Applied!"];
       }];

    }];
    [alert show];
}

@end
