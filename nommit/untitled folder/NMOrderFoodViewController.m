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
#import "NMOrderFoodConfirmAddressCell.h"
#import "NMOrderFoodOrderButtonCell.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import "NMAddressSearchViewController.h"
#import "NMMenuNavigationController.h"
#import "NMRateViewController.h"
#import "NMDeliveryViewController.h"
#import "NMPromoCodeTableViewCell.h"

const NSInteger NMInfoSection = 0;
const NSInteger NMProgressSection = 1;
const NSInteger NMOrderFoodConfirmationSection = 3;
const NSInteger NMOrderButtonSection = 4;
const NSInteger NMOrderPromoSection = 2;

static NSString *NMOrderFoodInfoIdentifier = @"NMOrderFoodInfoCell";
static NSString *NMOrderFoodProgressIdentifier = @"NMOrderFoodProgressCell";
static NSString *NMOrderFoodConfirmAddressCellIdentifier = @"NMOrderFoodConfirmAddressCell";
static NSString *NMOrderFoodButtonIdentifier = @"NMOrderFoodOrderButtonCell";
static NSString *NMOrderFoodPromoIdentifier = @"NMOrderFoodPromoCell";


@interface NMOrderFoodViewController ()<APParallaxViewDelegate>

@property (nonatomic, strong) NMOrderFoodInfoCell *infoCell;
@property (nonatomic, strong) NMOrderFoodProgressCell *progressCell;
@property (nonatomic, strong) NMOrderFoodConfirmAddressCell *confirmAddressCell;
@property (nonatomic, strong) NMOrderFoodProgressCell *promoCell;

@property (nonatomic, strong) NMFood *food;
@property (nonatomic, strong) NMPlace *place;

@end

@implementation NMOrderFoodViewController

- (instancetype)initWithFood:(NMFood *)food place:(NMPlace *)place {
    self = [super initWithStyle:UITableViewStylePlain];

    _food = food;
    _place = place;
    
    _orderModel = [[NMOrderApiModel alloc] init];
    _orderModel.food = [MTLManagedObjectAdapter modelOfClass:[NMFoodApiModel class] fromManagedObject:_food error:nil];
    _orderModel.place = [MTLManagedObjectAdapter modelOfClass:[NMPlaceApiModel class] fromManagedObject:_place error:nil];


    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[NMOrderFoodInfoCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
    [self.tableView registerClass:[NMOrderFoodProgressCell class] forCellReuseIdentifier:NMOrderFoodProgressIdentifier];
    [self.tableView registerClass:[NMOrderFoodConfirmAddressCell class] forCellReuseIdentifier:NMOrderFoodConfirmAddressCellIdentifier];
    [self.tableView registerClass:[NMOrderFoodOrderButtonCell class] forCellReuseIdentifier:NMOrderFoodButtonIdentifier];
    [self.tableView registerClass:[NMPromoCodeTableViewCell class] forCellReuseIdentifier:NMOrderFoodPromoIdentifier];

    [self.tableView addParallaxWithImage:nil andHeight:150];
    [self.tableView.parallaxView setDelegate:self];
    [self.tableView.parallaxView.imageView setImageWithURL:food.headerImageAsURL];

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
    } else if (indexPath.section == NMOrderFoodConfirmationSection || indexPath.section == NMOrderPromoSection) {
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
    } else if (section == NMOrderFoodConfirmationSection) {
        return 1;
    } else if (section == NMOrderButtonSection) {
        return 1;
    } else if (section == NMOrderPromoSection) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodInfoIdentifier];

        _infoCell.nameLabel.text = _food.title;
        _infoCell.descriptionLabel.text = _food.details;
        _infoCell.priceLabel.text = [NSString stringWithFormat:@"$%@", _food.price];

        return _infoCell;
    } else if (indexPath.section == NMProgressSection) {
        _progressCell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodProgressIdentifier];

        _progressCell.progressBarView.progress = @(_food.orderCount.floatValue / _food.orderGoal.floatValue).floatValue;
        _progressCell.quantityInput.value = [_orderModel.quantity integerValue] || 1;
        _progressCell.delegate = self;

        _progressCell.progressLabel.text = [NSString stringWithFormat:@"%@ left", _food.remainingOrders];
        _progressCell.progressLabel.textAlignment = NSTextAlignmentCenter;

        return _progressCell;
    } else if (indexPath.section == NMOrderFoodConfirmationSection) {
        _confirmAddressCell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodConfirmAddressCellIdentifier];
        return _confirmAddressCell;
    } else if (indexPath.section == NMOrderPromoSection) {
        _promoCell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodPromoIdentifier];
        return _promoCell;
    } else if (indexPath.section == NMOrderButtonSection) {
        NMOrderFoodOrderButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodButtonIdentifier];
        [cell.orderButton addTarget:self action:@selector(orderFoodButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - Navigation Bar Customization

- (void)initNavBar
{
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;

}

#pragma mark - order food button
- (void)orderFoodButtonPressed
{
    NMDeliveryViewController *rateVC = [[NMDeliveryViewController alloc] initWithOrder:nil];
    [self.navigationController pushViewController:rateVC animated:YES];

}

# pragma mark - Respond to quantity changes

- (void)quantityDidChange {
    if (_progressCell.quantityInput.value < 1) _progressCell.quantityInput.value = 1;

    _orderModel.quantity = @(_progressCell.quantityInput.value);

    _infoCell.priceLabel.text = [NSString stringWithFormat:@"$%@", @(_orderModel.quantity.floatValue * _food.price.floatValue)];
}

@end
