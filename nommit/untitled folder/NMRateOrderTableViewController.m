//
//  NMRateTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRateOrderTableViewController.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMDeliveryCallButtonTableViewCell.h"
#import "NMMenuNavigationController.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMDeliveryCallButtonTableViewCell.h"
#import "NMMenuNavigationController.h"
#import "NMReceiptTableViewCell.h"
#import "UIScrollView+NMParallaxHeader.h"

@interface NMRateOrderTableViewController ()<APParallaxViewDelegate>

@property (nonatomic, strong) NMOrder *order;
@property (nonatomic, strong) NMDeliveryAvatarsTableViewCell *avatarsCell;
@property (nonatomic, strong) NMDeliveryCallButtonTableViewCell *callButtonCell;
@property (nonatomic, strong) NMReceiptTableViewCell *receiptCell;
@property (nonatomic, strong) NSNumber *totalAmount;

@end

@implementation NMRateOrderTableViewController

const NSInteger NMRateAvatarsSection = 0;
const NSInteger NMRateReceiptSection = 1;
const NSInteger NMRateCallButtonSection = 2;

static NSString *NMRateAvatarsInfoIdentifier = @"NMDeliveryAvatarsTableViewCell";
static NSString *NMRateReceiptInfoIdentifier = @"NMReceiptTableViewCell";
static NSString *NMRateDoneButtonInfoIdentifier = @"NMDeliveryDoneButtonTableViewCell";

- (id)initWithOrder:(NMOrder *)order {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.tableView.scrollEnabled = NO;
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _order = order;
        _totalAmount = @([_order.priceInCents integerValue] / 100);
        
        
        [self.tableView addParallaxWithImage:nil andHeight:90];
        [self.tableView.parallaxView setDelegate:self];
        [self.tableView.parallaxView.imageView setImageWithURL:order.food.headerImageAsURL placeholderImage:[UIImage imageNamed:@"LoadingImage"]];
        [self.tableView addBlackOverlayToParallaxView];
        
        // register table view cells
        [self.tableView registerClass:[NMDeliveryAvatarsTableViewCell class] forCellReuseIdentifier:NMRateAvatarsInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCallButtonTableViewCell class] forCellReuseIdentifier:NMRateDoneButtonInfoIdentifier];
        [self.tableView registerClass:[NMReceiptTableViewCell class] forCellReuseIdentifier:NMRateReceiptInfoIdentifier];
        
        [self initNavBar];
    }
    return self;
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
    if (indexPath.section == NMRateAvatarsSection) {
        return 120;
    } else if (indexPath.section == NMRateReceiptSection) {
        return 305;
    } else if (indexPath.section == NMRateCallButtonSection) {
        return 53;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMRateAvatarsSection) {
        _avatarsCell = [self.tableView dequeueReusableCellWithIdentifier:NMRateAvatarsInfoIdentifier];
        int price = (int)[_order.priceInCents integerValue]/100;
        _avatarsCell.priceLabel.text = [NSString stringWithFormat:@"$%d", price];
        _avatarsCell.updateLabel.text = [NSString stringWithFormat:@"%@ delivered %@ orders of %@ from %@  to you for $%d.", _order.courier.user.name, _order.quantity, _order.food.title, _order.food.seller.name, price];
        [_avatarsCell setupCourierAvatarWithProfileId:_order.courier.user.facebookUID];
        [_avatarsCell.avatarSeller setImageWithURL:_order.food.seller.logoAsURL placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
        return _avatarsCell;
    } else if (indexPath.section == NMRateReceiptSection) {
        _receiptCell = [self.tableView dequeueReusableCellWithIdentifier:NMRateReceiptInfoIdentifier];
        [_receiptCell.plusButton addTarget:self action:@selector(addOneToTip) forControlEvents:UIControlEventTouchUpInside];
        [_receiptCell.minusButton addTarget:self action:@selector(minusOneFromTip) forControlEvents:UIControlEventTouchUpInside];
        _receiptCell.tipLabel.text = [NSString stringWithFormat:@"$%@", _totalAmount];
        [self enableMinusButton];
        return _receiptCell;
    } else if (indexPath.section == NMRateCallButtonSection) {
        _callButtonCell = [self.tableView dequeueReusableCellWithIdentifier:NMRateDoneButtonInfoIdentifier];
        [_callButtonCell.callButton setTitle:@"Done" forState:UIControlStateNormal];
        [_callButtonCell.callButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
        return _callButtonCell;
    }
    return nil;
}

- (void)enableMinusButton {
    if ([_totalAmount integerValue] > (int)[_order.priceInCents integerValue] / 100) {
        _receiptCell.minusButton.alpha = 1.0f;
        _receiptCell.minusButton.enabled = YES;
    } else {
        _receiptCell.minusButton.alpha = 0.5f;
        _receiptCell.minusButton.enabled = NO;
    }
}

- (void)addOneToTip {
    _totalAmount = @(_totalAmount.intValue + 1);
    _receiptCell.tipLabel.text = [NSString stringWithFormat:@"$%@", _totalAmount];
    [self enableMinusButton];
}

- (void)minusOneFromTip {
    _totalAmount = @(_totalAmount.intValue - 1);
    _receiptCell.tipLabel.text = [NSString stringWithFormat:@"$%@", _totalAmount];
    [self enableMinusButton];
}

- (void)done {
    NSString *path = [NSString stringWithFormat:@"orders/%@", _order.uid];
    NSNumber *tip = @(_totalAmount.intValue * 100 - _order.priceInCents.intValue);
    NSDictionary *params = @{ @"tip_in_cents" : tip, @"rating" : @(_receiptCell.rateVw.rating), @"state_id" : @(NMOrderStateRated) };
    
    [[NMApi instance] PUT:path parameters:params completion:^(OVCResponse *response, NSError *error) {

        if (error) {
            [response.result handleError];
        }
    }];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(BOOL)prefersStatusBarHidden { return YES; }

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 86.5*1.3, 21*1.3)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(15, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    self.navigationController.navigationBarHidden = NO;
    
}

@end
