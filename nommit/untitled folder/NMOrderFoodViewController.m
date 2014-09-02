//
//  NMOrderFoodViewController.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodViewController.h"

#import "NMOrderFoodInfoCell.h"
#import "NMOrderFoodProgressCell.h"
#import "NMOrderFoodDeliveryDetailsCell.h"
#import "NMOrderFoodOrderButtonCell.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

const NSInteger NMInfoSection = 0;
const NSInteger NMProgressSection = 1;
const NSInteger NMOrderDeliveryDetailsSection = 2;
const NSInteger NMOrderButtonSection = 3;

static NSString *NMOrderFoodInfoIdentifier = @"NMOrderFoodInfoCell";
static NSString *NMOrderFoodProgressIdentifier = @"NMOrderFoodProgressCell";
static NSString *NMOrderFoodDeliveryIdentifier = @"NMOrderFoodDeliveryDetailsCell";
static NSString *NMOrderFoodButtonIdentifier = @"NMOrderFoodOrderButtonCell";

@interface NMOrderFoodViewController ()<APParallaxViewDelegate>

@property (nonatomic, strong) NMFoodItem *foodItem;

@end

@implementation NMOrderFoodViewController

- (instancetype)initWithFoodItem:(NMFoodItem *)foodItem {
    self = [super initWithStyle:UITableViewStylePlain];
    _foodItem = foodItem;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[NMOrderFoodInfoCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
    [self.tableView registerClass:[NMOrderFoodProgressCell class] forCellReuseIdentifier:NMOrderFoodProgressIdentifier];
    [self.tableView registerClass:[NMOrderFoodDeliveryDetailsCell class] forCellReuseIdentifier:NMOrderFoodDeliveryIdentifier];
    [self.tableView registerClass:[NMOrderFoodOrderButtonCell class] forCellReuseIdentifier:NMOrderFoodButtonIdentifier];
    
    [self.tableView addParallaxWithImage:foodItem.headerImage andHeight:150];
    [self.tableView.parallaxView setDelegate:self];
    
    [self initNavBar];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMInfoSection) {
        return 125;
    } else if (indexPath.section == NMProgressSection) {
        return 125;
    } else if (indexPath.section == NMOrderDeliveryDetailsSection) {
        return 50;
    } else if (indexPath.section == NMOrderButtonSection) {
        return 66;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == NMInfoSection) {
        return 1;
    } else if (section == NMProgressSection) {
        return 1;
    } else if (section == NMOrderDeliveryDetailsSection) {
        return 3;
    } else if (section == NMOrderButtonSection) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMInfoSection) {
        NMOrderFoodInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodInfoIdentifier];
        cell.nameLabel.text = _foodItem.itemName;
        cell.descriptionLabel.text = _foodItem.description;
        cell.priceLabel.text = [NSString stringWithFormat:@"$%d", _foodItem.price];
        
        return cell;
    } else if (indexPath.section == NMProgressSection) {
        NMOrderFoodProgressCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodProgressIdentifier];
        cell.progressBarView.progress = 0.5f;
        
        return cell;
    } else if (indexPath.section == NMOrderDeliveryDetailsSection) {
        NMOrderFoodDeliveryDetailsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodDeliveryIdentifier];
        return cell;
    
    } else if (indexPath.section == NMOrderButtonSection) {
        NMOrderFoodOrderButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodButtonIdentifier];
        
        return cell;
        
    }
    return nil;
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

#pragma mark - Navigation Bar Customization

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchMenu)];
    
    lbb.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 37.5)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width/2, titleImageView.frame.size.height/2);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
    self.navigationItem.title = @"WTFFFF";
}

@end
