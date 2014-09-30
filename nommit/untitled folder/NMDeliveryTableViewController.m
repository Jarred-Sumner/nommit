//
//  NMDeliveryTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryTableViewController.h"
#import "NMMenuNavigationController.h"
#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMDeliveryCountdownTableViewCell.h"
#import "NMDeliveryCallButtonTableViewCell.h"
#import "UIScrollView+NMParallaxHeader.h"

static NSTimeInterval NMOrderFetchInterval = 10;


@interface NMDeliveryTableViewController ()<APParallaxViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) NSTimer *fetchOrderTimer;

@property (nonatomic, strong) NMOrder *order;

@property (nonatomic, strong) NMDeliveryAvatarsTableViewCell *avatarsCell;
@property (nonatomic, strong) NMDeliveryCountdownTableViewCell *countdownCell;
@property (nonatomic, strong) NMDeliveryCallButtonTableViewCell *callButtonCell;

@end

@implementation NMDeliveryTableViewController

const NSInteger NMAvatarsSection = 0;
const NSInteger NMCountdownSection = 1;
const NSInteger NMCallButtonSection = 2;

static NSString *NMAvatarsInfoIdentifier = @"NMDeliveryAvatarsTableViewCell";
static NSString *NMCountDownInfoIdentifier = @"NMDeliveryCountdownTableViewCell";
static NSString *NMCallButtonInfoIdentifier = @"NMDeliveryCallButtonTableViewCell";



- (id)initWithOrder:(NMOrder *)order {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _order = order;
        
        [self.tableView addParallaxWithImage:nil andHeight:150];
        [self.tableView.parallaxView setDelegate:self];
        [self.tableView.parallaxView.imageView setImageWithURL:order.food.headerImageAsURL];
        [self.tableView addBlackOverlayToParallaxView];
        
        
        // register table view cells
        [self.tableView registerClass:[NMDeliveryAvatarsTableViewCell class] forCellReuseIdentifier:NMAvatarsInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCountdownTableViewCell class] forCellReuseIdentifier:NMCountDownInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCallButtonTableViewCell class] forCellReuseIdentifier:NMCallButtonInfoIdentifier];
        
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
    // make total 354
    if (indexPath.section == NMAvatarsSection) {
        return 120;
    } else if (indexPath.section == NMCountdownSection) {
        return 184;
    } else if (indexPath.section == NMCallButtonSection) {
        return 50;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAvatarsSection) {
        _avatarsCell = [self.tableView dequeueReusableCellWithIdentifier:NMAvatarsInfoIdentifier];
        int price = (int)[_order.priceInCents integerValue]/100;
        _avatarsCell.priceLabel.text = [NSString stringWithFormat:@"$%d", price];
        _avatarsCell.updateLabel.text = [NSString stringWithFormat:@"%@ is delivering %@ orders of %@ from %@ to you for $%d.", _order.courier.user.name, _order.quantity, _order.food.title, _order.food.seller.name, price];
        [_avatarsCell setupCourierAvatarWithProfileId:_order.courier.user.facebookUID];
        [_avatarsCell.avatarSeller setImageWithURL:_order.food.seller.logoAsURL];
        return _avatarsCell;
    } else if (indexPath.section == NMCountdownSection) {
        _countdownCell = [self.tableView dequeueReusableCellWithIdentifier:NMCountDownInfoIdentifier];
        _countdownCell.deliveryPlace.text = [NSString stringWithFormat:@"Arriving at %@ in", _order.place.name];
        [_countdownCell.timerLabel setCountDownToDate:_order.deliveredAt];
        [_countdownCell.timerLabel start];
        return _countdownCell;
    } else if (indexPath.section == NMCallButtonSection) {
        _callButtonCell = [self.tableView dequeueReusableCellWithIdentifier:NMCallButtonInfoIdentifier];
        [_callButtonCell.callButton setTitle:[NSString stringWithFormat:@"Call %@", _order.courier.user.name] forState:UIControlStateNormal];
        [_callButtonCell.callButton addTarget:self action:@selector(callCourier) forControlEvents:UIControlEventTouchUpInside];
        return _callButtonCell;
    }
    return nil;
}

- (void)updateCells {
    [_countdownCell.timerLabel pause];
    [_countdownCell.timerLabel setCountDownToDate:_order.deliveredAt];
    [_countdownCell.timerLabel start];
}

#pragma mark - call courier
- (void)callCourier
{
    NSString *phNo = _order.courier.user.phone;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

#pragma mark - navigation bar

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

#pragma mark - Update Delivery Times

- (void)startFetchingOrderStatus {
    _fetchOrderTimer = [NSTimer scheduledTimerWithTimeInterval:NMOrderFetchInterval target:self selector:@selector(fetchOrderStatus) userInfo:nil repeats:YES];
    [self fetchOrderStatus];
}

- (void)fetchOrderStatus {
    __block NMDeliveryTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"orders/%@", _order.uid] parameters:nil completion:^(OVCResponse *response, NSError *error) {
        if ([response.result class] == [NMOrderApiModel class]) {
            this.order = [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:[NSManagedObjectContext MR_defaultContext] error:&error];
            [this updateCells];
        }
    }];
}

@end
