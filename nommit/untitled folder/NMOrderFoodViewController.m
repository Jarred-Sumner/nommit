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
#import "NMAddressSearchViewController.h"
#import "NMDeliveryAddressTableViewCell.h"
#import "NMMenuNavigationController.h"

const NSInteger NMInfoSection = 0;
const NSInteger NMProgressSection = 1;
const NSInteger NMDeliveryAddressSection = 2;
const NSInteger NMOrderDeliveryDetailsSection = 3;
const NSInteger NMOrderButtonSection = 4;

static NSString *NMOrderFoodInfoIdentifier = @"NMOrderFoodInfoCell";
static NSString *NMOrderFoodProgressIdentifier = @"NMOrderFoodProgressCell";
static NSString *NMOrderFoodDeliveryAddressIdentifier = @"NMDeliveryAddressTableViewCell";
static NSString *NMOrderFoodDeliveryIdentifier = @"NMOrderFoodDeliveryDetailsCell";
static NSString *NMOrderFoodButtonIdentifier = @"NMOrderFoodOrderButtonCell";

@interface NMOrderFoodViewController ()<APParallaxViewDelegate, NMOrderFoodProgressCell, NMOrderFoodOrderButtonCell> {
    NSString *destAddress;
    NSString *destTime;
    NMDeliveryAddressTableViewCell *addressCell;
}

@end

@implementation NMOrderFoodViewController

- (instancetype)initWithFoodItem:(NMFoodItem *)foodItem {
    self = [super initWithStyle:UITableViewStylePlain];
    destAddress = @"2211 mission street, San Francisco, CA 15232";
    destTime = @"Est 2 min";
//    [self getAddressOfCurrentLocation:^(NSString *address, NSString *dTime) {
//        destAddress = address;
//        destTime = dTime;
//        [self.tableView reloadData];
//    }];
    
    _foodItem = foodItem;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[NMOrderFoodInfoCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
    [self.tableView registerClass:[NMOrderFoodProgressCell class] forCellReuseIdentifier:NMOrderFoodProgressIdentifier];
    [self.tableView registerClass:[NMDeliveryAddressTableViewCell class] forCellReuseIdentifier:NMOrderFoodDeliveryAddressIdentifier];
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
        return 100;
    } else if (indexPath.section == NMProgressSection) {
        return 103;
    } else if (indexPath.section == NMOrderDeliveryDetailsSection || indexPath.section == NMDeliveryAddressSection) {
        return 50;
    } else if (indexPath.section == NMOrderButtonSection) {
        return 49;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == NMInfoSection) {
        return 1;
    } else if (section == NMProgressSection) {
        return 1;
    } else if (section == NMDeliveryAddressSection) {
        return 1;
    } else if (section == NMOrderDeliveryDetailsSection) {
        return 1;
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
        cell.delegate = self;
        cell.progressBarView.progress = 0.5f;
        NSNumber *left = [NSNumber numberWithInt:_foodItem.itemsTotal - _foodItem.itemsSold];
        NSNumber *total = [NSNumber numberWithInt:_foodItem.itemsTotal];
        cell.leftSold = @[left, total];
        
        return cell;
    } else if (indexPath.section == NMDeliveryAddressSection) {
        NMDeliveryAddressTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodDeliveryAddressIdentifier];
        addressCell = cell;
        cell.currentAddress.text = destAddress;
        cell.estimatedTime.text = destTime;
        return cell;
    } else if (indexPath.section == NMOrderDeliveryDetailsSection) {
        NMOrderFoodDeliveryDetailsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodDeliveryIdentifier];
        cell.textField.placeholder = @"Room #";
        return cell;
    } else if (indexPath.section == NMOrderButtonSection) {
        NMOrderFoodOrderButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodButtonIdentifier];
        
        return cell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMDeliveryAddressSection) {
        NMAddressSearchViewController *addressSearchVC = [[NMAddressSearchViewController alloc] init];
        addressSearchVC.delegate = self;
        NMMenuNavigationController *navController =
        [[NMMenuNavigationController alloc] initWithRootViewController:addressSearchVC];
        [self presentViewController:navController animated:YES completion:nil];
    }
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
//    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
//                                                            style:UIBarButtonItemStylePlain
//                                                           target:self
//                                                           action:@selector(launchMenu)];
//    
//    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
//    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
}

#pragma mark - digit input delegates

-(void)didBeginEditing:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"did begin editing %i",input.value);
}

-(void)didEndEditing:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"did end editing %i",input.value);
}

-(void)textDidChange:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"text did change %i",input.value);
}

-(void)valueChanged:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"value changed %i",input.value);
}

#pragma mark - order food button
- (void)orderFoodButtonPressed:(id)sender
{
    NSLog(@"Your food has been ordered!");
    NMAddressSearchViewController *addressSearchVC = [[NMAddressSearchViewController alloc] init];
    [self presentViewController:addressSearchVC animated:YES completion:nil];
    
}

#pragma mark - AddressSearchViewController delegate methods
- (void)setSelectedAddress:(NSString *)address {
    destAddress = address;
    addressCell.currentAddress.text = address;
    [addressCell.currentAddress setNeedsDisplay];
}



@end
