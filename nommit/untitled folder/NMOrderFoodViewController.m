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
#import "NMDeliveryTableViewController.h"
#import "NMPromoCodeTableViewCell.h"
#import "NMOrderFoodDescriptionTableViewCell.h"
#import "NMDeliveryTableViewController.h"
#import "UIScrollView+NMParallaxHeader.h"
#import <SIAlertView/SIAlertView.h>
#import "NMApi.h"

const NSInteger NMInfoSection = 0;
const NSInteger NMDescriptionSecton = 1;
const NSInteger NMProgressSection = 2;
const NSInteger NMOrderFoodConfirmationSection = 4;
const NSInteger NMOrderButtonSection = 5;
const NSInteger NMOrderPromoSection = 3;

static NSString *NMOrderFoodInfoIdentifier = @"NMOrderFoodInfoCell";
static NSString *NMOrderFoodDescriptionIdentifier = @"NMOrderFoodDescriptionCell";
static NSString *NMOrderFoodProgressIdentifier = @"NMOrderFoodProgressCell";
static NSString *NMOrderFoodConfirmAddressCellIdentifier = @"NMOrderFoodConfirmAddressCell";
static NSString *NMOrderFoodButtonIdentifier = @"NMOrderFoodOrderButtonCell";
static NSString *NMOrderFoodPromoIdentifier = @"NMOrderFoodPromoCell";


@interface NMOrderFoodViewController ()<APParallaxViewDelegate>

@property BOOL confirmed;

// @property (nonatomic, strong) NMOrderFoodInfoCell *infoCell;
@property (nonatomic, strong) NMOrderFoodBasicInfoTableViewCell *infoCell;
@property (nonatomic, strong) NMOrderFoodDescriptionTableViewCell *descriptionCell;
@property (nonatomic, strong) NMOrderFoodProgressCell *progressCell;
@property (nonatomic, strong) NMOrderFoodConfirmAddressCell *confirmAddressCell;
@property (nonatomic, strong) NMPromoCodeTableViewCell *promoCell;

@property (nonatomic, strong) NMFood *food;
@property (nonatomic, strong) NMPlace *place;

@end

@implementation NMOrderFoodViewController

- (instancetype)initWithFood:(NMFood *)food place:(NMPlace *)place {
    self = [super initWithStyle:UITableViewStylePlain];

    _food = food;
    _place = place;
    
    _orderModel = [[NMOrderApiModel alloc] init];


    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // [self.tableView registerClass:[NMOrderFoodInfoCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
    [self.tableView registerClass:[NMOrderFoodBasicInfoTableViewCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
    [self.tableView registerClass:[NMOrderFoodDescriptionTableViewCell class] forCellReuseIdentifier:NMOrderFoodDescriptionIdentifier];
    [self.tableView registerClass:[NMOrderFoodProgressCell class] forCellReuseIdentifier:NMOrderFoodProgressIdentifier];
    [self.tableView registerClass:[NMOrderFoodConfirmAddressCell class] forCellReuseIdentifier:NMOrderFoodConfirmAddressCellIdentifier];
    [self.tableView registerClass:[NMOrderFoodOrderButtonCell class] forCellReuseIdentifier:NMOrderFoodButtonIdentifier];
    [self.tableView registerClass:[NMPromoCodeTableViewCell class] forCellReuseIdentifier:NMOrderFoodPromoIdentifier];

    [self.tableView addParallaxWithImage:nil andHeight:150];
    [self.tableView.parallaxView setDelegate:self];
    [self.tableView addBlackOverlayToParallaxView];
    [self.tableView addTitleToParallaxView:_food.title];
    [self.tableView.parallaxView.imageView setImageWithURL:food.headerImageAsURL placeholderImage:[UIImage imageNamed:@"LoadingImage"]];

    return self;
}


// The pan gesture recognizer messes with iOS 7 swipe to go back.
// So, we disable the menu for this page.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = _food.title;
    
    [(NMMenuNavigationController*)self.navigationController setDisabledMenu:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [(NMMenuNavigationController*)self.navigationController setDisabledMenu:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // make total 354
    if (indexPath.section == NMInfoSection) {
        return 68;
    } else if (indexPath.section == NMDescriptionSecton) {
        return 83;
    } else if (indexPath.section == NMProgressSection) {
        return 69;
    } else if (indexPath.section == NMOrderFoodConfirmationSection || indexPath.section == NMOrderPromoSection) {
        return 42.5;
    } else if (indexPath.section == NMOrderButtonSection) {
        return 49;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == NMInfoSection) {
        return 1;
    } else if (section == NMDescriptionSecton) {
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
        
        [_infoCell.avatar setImageWithURL:_food.seller.logoAsURL];
        _infoCell.nameLabel.text = [NSString stringWithFormat:@"By %@", _food.seller.name];
        _infoCell.priceLabel.text = [NSString stringWithFormat:@"$%@", _food.price];
        _infoCell.quantityInput.value = [_orderModel.quantity integerValue] || 1;
        return _infoCell;
    } else if (indexPath.section == NMDescriptionSecton) {
        _descriptionCell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodDescriptionIdentifier];
        _descriptionCell.descriptionLabel.text = _food.details;
        return _descriptionCell;
    } else if (indexPath.section == NMProgressSection) {
        _progressCell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodProgressIdentifier];

        _progressCell.progressBarView.progress = @(_food.orderCount.floatValue / _food.orderGoal.floatValue).floatValue;

        _progressCell.progressLabel.text = [NSString stringWithFormat:@"%@ left", _food.remainingOrders];
        _progressCell.progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressCell.rateVw.rating = [_food.rating floatValue];

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {}

#pragma mark - order food button
- (void)orderFoodButtonPressed
{
    if (_confirmAddressCell.checkbox.checkState == M13CheckboxStateUnchecked) _confirmed = NO;
    if (_confirmAddressCell.checkbox.checkState != M13CheckboxStateChecked && !_confirmed) {
        __block NMOrderFoodViewController *this = self;
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Confirm Pickup Location" andMessage:[NSString stringWithFormat:@"Please confirm you will meet in the lobby of %@ to pick up your order.", _place.name]];
        [alert addButtonWithTitle:@"Cancel" type:SIAlertViewButtonTypeCancel handler:NULL];
        [alert addButtonWithTitle:@"Confirm" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            [_confirmAddressCell.checkbox setCheckState:M13CheckboxStateChecked];
            this.confirmed = YES;
            [this orderFoodButtonPressed];
        }];
        [alert show];
        return;
    }
    _orderModel.promoCode = _promoCell.textField.text;

    __weak NMOrderFoodViewController *this = self;
    [SVProgressHUD showWithStatus:@"Placing Order..." maskType:SVProgressHUDMaskTypeBlack];
    NSDictionary *params = [_orderModel createParamsWithFood:_food place:_place];
    [[NMApi instance] POST:@"orders" parameters:params completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"Order Placed!"];

        NMOrder *order = [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:[NSManagedObjectContext MR_defaultContext] error:&error];

        NMDeliveryTableViewController *deliverVC = [[NMDeliveryTableViewController alloc] initWithOrder:order];

        [this.navigationController pushViewController:deliverVC animated:YES];
    
    }];
}

# pragma mark - Respond to quantity changes

- (void)quantityDidChange {
    if (_infoCell.quantityInput.value < 1) _infoCell.quantityInput.value = 1;

    _orderModel.quantity = @(_infoCell.quantityInput.value);

    _infoCell.priceLabel.text = [NSString stringWithFormat:@"$%@", @(_orderModel.quantity.floatValue * _food.price.floatValue)];
}

@end
