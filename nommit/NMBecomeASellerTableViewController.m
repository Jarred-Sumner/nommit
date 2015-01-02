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
#import "NMBecomeASellerApplyTableViewCell.h"


const NSInteger NMBecomeASellerBannerSection = 0;
const NSInteger NMBecomeASellerInfoSection = 1;
const NSInteger NMBecomeASellerApplySection = 2;

static NSString *NMBecomeASellerBannerIdentifier = @"NMBecomeASellerBannerCell";
static NSString *NMBecomeASellerInfoIdentifier = @"NMBecomeASellerInfoCell";
static NSString *NMBecomeASellerApplyIdentifier = @"NMBecomeASellerApplyCell";

@interface NMBecomeASellerTableViewController ()

@property (nonatomic, strong) NMBecomeASellerBannerTableViewCell *bannerCell;
@property (nonatomic, strong) NMBecomeASellerInfoTableViewCell *infoCell;
@property (nonatomic, strong) NMBecomeASellerApplyTableViewCell *applyCell;

@end

@implementation NMBecomeASellerTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView registerClass:[NMBecomeASellerBannerTableViewCell class] forCellReuseIdentifier:NMBecomeASellerBannerIdentifier];
        [self.tableView registerClass:[NMBecomeASellerInfoTableViewCell class] forCellReuseIdentifier:NMBecomeASellerInfoIdentifier];
        [self.tableView registerClass:[NMBecomeASellerApplyTableViewCell class] forCellReuseIdentifier:NMBecomeASellerApplyIdentifier];
        
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
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    if (!self.navigationItem.leftBarButtonItem) self.navigationItem.leftBarButtonItem = lbb;
    
    self.navigationController.navigationBarHidden = NO;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMBecomeASellerBannerSection) {
        return 84;
    } else if (indexPath.section == NMBecomeASellerInfoSection) {
        return 288;
    } else if (indexPath.section == NMBecomeASellerApplySection) {
        return 132;
    } return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMBecomeASellerBannerSection) {
        _bannerCell = [self.tableView dequeueReusableCellWithIdentifier:NMBecomeASellerBannerIdentifier];
        _bannerCell.bannerLabel.text = @"Make from $15/hour to over $150/hour selling food people want.";
        return _bannerCell;
    } else if (indexPath.section == NMBecomeASellerInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMBecomeASellerInfoIdentifier];
        _infoCell.dollarTitle.text = @"Get Food";
        _infoCell.chefTitle.text = @"Prepare Food";
        _infoCell.peopleTitle.text = @"Deliver Food";
        
        _infoCell.dollarDesc.text = @"Buy fresh food people want from restaurants and grocery stores.";
        _infoCell.chefDesc.text = @"Heat, box, and package all of it before deliveries start.";
        _infoCell.peopleDesc.text = @"Gather 3-4 friends, and deliver the food together!";
        
        return _infoCell;
    } else if (indexPath.section == NMBecomeASellerApplySection) {
        _applyCell = [self.tableView dequeueReusableCellWithIdentifier:NMBecomeASellerApplyIdentifier];
        // _applyCell.becomeASellerLabel.text = @"Become A Seller";
        [_applyCell.applyButton addTarget:self action:@selector(applyToBeSeller) forControlEvents:UIControlEventTouchUpInside];
        return _applyCell;
    }
    return nil;
}

- (void)applyToBeSeller {
    
}

@end
