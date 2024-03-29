//
//  NMDeliveryTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMDeliveryTableViewController.h"
#import "NMNavigationController.h"
#import "NMMenuViewController.h"
#import "NMRateOrderTableViewController.h"
#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMDeliveryCountdownTableViewCell.h"
#import "NMDeliveryCallButtonTableViewCell.h"
#import "UIScrollView+NMParallaxHeader.h"
#import "NMFoodsTableViewController.h"
#import <AudioToolbox/AudioServices.h>
#import "NMSupportViewController.h"
#import <MessageUI/MessageUI.h>

typedef NS_ENUM(NSInteger, NMDeliveryCountdownState) {
    NMDeliveryCountdownStateCounting,
    NMDeliveryCountdownStateArrivingSoon,
    NMDeliveryCountdownStateArrived,
};

static NSTimeInterval NMOrderFetchInterval = 7;
static NSTimeInterval NMCountdownFlashInterval = 0.75f;


@interface NMDeliveryTableViewController ()<APParallaxViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic) NMDeliveryCountdownState state;
@property (nonatomic, strong) NSDate *arrivalEstimate;
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
        [self.tableView.parallaxView.imageView setImageWithURL:order.food.headerImageAsURL placeholderImage:[UIImage imageNamed:@"LoadingImage"]];
        [self.tableView addBlackOverlayToParallaxView];
        
        
        // register table view cells
        [self.tableView registerClass:[NMDeliveryAvatarsTableViewCell class] forCellReuseIdentifier:NMAvatarsInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCountdownTableViewCell class] forCellReuseIdentifier:NMCountDownInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCallButtonTableViewCell class] forCellReuseIdentifier:NMCallButtonInfoIdentifier];
        
        [self initNavBar];
    }
    return self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self stopFetchingOrderStatus];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startFetchingOrderStatus];
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
        return 140;
    } else if (indexPath.section == NMCountdownSection) {
        return 164;
    } else if (indexPath.section == NMCallButtonSection) {
        return 50;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMAvatarsSection) {
        _avatarsCell = [self.tableView dequeueReusableCellWithIdentifier:NMAvatarsInfoIdentifier];
        NSNumber *price = @([_order.priceChargedInCents doubleValue] / 100.f);
        _avatarsCell.priceLabel.text = [NSString stringWithFormat:@"$%@", price];
        if ([_order.quantity integerValue] > 1) {
            NSString *text = [NSString stringWithFormat:@"%@ is delivering %@ orders of %@ from %@ to you for $%@.", _order.courier.user.name, _order.quantity, _order.food.title, _order.food.seller.name, price];
            
            __block NMDeliveryTableViewController *this = self;
            [_avatarsCell.updateLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                NSRange courierRange = [[mutableAttributedString string] rangeOfString:this.order.courier.user.name];
                NSRange quantityRange = [[mutableAttributedString string] rangeOfString:[this.order.quantity stringValue]];
                NSRange foodRange = [[mutableAttributedString string] rangeOfString:this.order.food.title];

                NSRange sellerRange = [[mutableAttributedString string] rangeOfString:this.order.food.seller.name];
                
                UIFont *uiFont = [UIFont fontWithName:@"Avenir-Medium" size:13.f];
                CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
                if (font) {
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:courierRange];
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:quantityRange];
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:sellerRange];
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:foodRange];
                }
                return mutableAttributedString;
            }];
            
        } else {
            NSString *text = [NSString stringWithFormat:@"%@ is delivering an order of %@ from %@ to you for $%@.", _order.courier.user.name, _order.food.title, _order.food.seller.name, price];
            
            __block NMDeliveryTableViewController *this = self;
            [_avatarsCell.updateLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
                NSRange courierRange = [[mutableAttributedString string] rangeOfString:this.order.courier.user.name];
                NSRange sellerRange = [[mutableAttributedString string] rangeOfString:this.order.food.seller.name];
                NSRange foodRange = [[mutableAttributedString string] rangeOfString:this.order.food.title];
                
                UIFont *uiFont = [UIFont fontWithName:@"Avenir-Medium" size:13.f];
                CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
                if (font) {
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:courierRange];
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:sellerRange];
                    [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:foodRange];
                }
                return mutableAttributedString;
            }];        }
        [_avatarsCell setupCourierAvatarWithProfileId:_order.courier.user.facebookUID];
        [_avatarsCell.avatarSeller setImageWithURL:_order.food.seller.logoAsURL placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
        return _avatarsCell;
    } else if (indexPath.section == NMCountdownSection) {
        _countdownCell = [self.tableView dequeueReusableCellWithIdentifier:NMCountDownInfoIdentifier];
        // Reset state
        self.order = self.order;
        return _countdownCell;
    } else if (indexPath.section == NMCallButtonSection) {
        _callButtonCell = [self.tableView dequeueReusableCellWithIdentifier:NMCallButtonInfoIdentifier];
        [_callButtonCell.callButton setTitle:[NSString stringWithFormat:@"Call %@", _order.courier.user.name] forState:UIControlStateNormal];
        [_callButtonCell.callButton addTarget:self action:@selector(callCourier) forControlEvents:UIControlEventTouchUpInside];
        return _callButtonCell;
    }
    return nil;
}

#pragma mark - call courier
- (void)callCourier
{
    NSString *phNo = _order.courier.user.phone;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Can't Place Calls" andMessage:@"This device can't place phone calls. Sorry about that."];
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
    }
}

#pragma mark - navigation bar

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    lbb.imageInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    self.title = @"Your Order";
    self.navigationController.navigationBarHidden = NO;
    
    // Setup cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    cancelButton.enabled = _order.placedAt.timeIntervalSinceNow > -120;
    self.navigationItem.rightBarButtonItem = cancelButton;
    
}

#pragma mark - Countdown State

- (void)setOrder:(NMOrder *)order {
    if (order.state == NMOrderStateActive) {
        self.arrivalEstimate = order.deliveredAt;
    } else if (order.state == NMOrderStateArrived) {
        self.state = NMDeliveryCountdownStateArrived;
    } else if (order.state == NMOrderStateDelivered) {
        [self stopFetchingOrderStatus];
        
        __block UINavigationController *navVC = self.navigationController;
        NMRateOrderTableViewController *rateVC = [[NMRateOrderTableViewController alloc] initWithOrder:order];
        [self.navigationController presentViewController:rateVC animated:YES completion:^{
            [navVC pushViewController:[[NMFoodsTableViewController alloc] init] animated:NO];
        }];
    }
    _order = order;
}

- (void)setState:(NMDeliveryCountdownState)state {
    if (!_countdownCell) return;
    
    __block NMDeliveryTableViewController *this = self;
    if (state == NMDeliveryCountdownStateArrived) {
        _countdownCell.timerLabel.hidden = YES;
        [_countdownCell.timerLabel pause];
        _countdownCell.statusLabel.hidden = NO;
        
        _countdownCell.deliveryPlaceLabel.text = [NSString stringWithFormat:@"%@ arrived at %@", _order.courier.user.name, _order.place.name];
        _countdownCell.statusLabel.text = [NSString stringWithFormat:@"Pick up in Lobby Now"];
        [UIView animateWithDuration:NMCountdownFlashInterval delay:0 options:(UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse) animations:^{
            _countdownCell.statusLabel.layer.opacity = 0.f;
            _countdownCell.statusLabel.layer.opacity = 1.f;
        } completion:NULL];
    } else if (state == NMDeliveryCountdownStateArrivingSoon) {
        _countdownCell.timerLabel.hidden = YES;
        [_countdownCell.timerLabel pause];
        _countdownCell.statusLabel.hidden = NO;
        _countdownCell.deliveryPlaceLabel.text = [NSString stringWithFormat:@"Arriving at %@ in", _order.place.name];
        _countdownCell.statusLabel.text = @"Any Minute Now";
        [_countdownCell.layer removeAllAnimations];
    } else if (state == NMDeliveryCountdownStateCounting) {
        _countdownCell.timerLabel.hidden = NO;
        _countdownCell.statusLabel.hidden = YES;
        _countdownCell.deliveryPlaceLabel.text = [NSString stringWithFormat:@"Arriving at %@ in", _order.place.name];
        [_countdownCell.timerLabel startWithEndingBlock:^(NSTimeInterval countTime) {
            this.state = NMDeliveryCountdownStateArrivingSoon;
        }];
        [_countdownCell.layer removeAllAnimations];
    }
    if (state == NMDeliveryCountdownStateArrived && _state != NMDeliveryCountdownStateArrived) {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    _state = state;
}

- (void)setArrivalEstimate:(NSDate *)arrivalEstimate {
    if (![arrivalEstimate isEqualToDate:_arrivalEstimate]) {
        [_countdownCell.timerLabel setCountDownToDate:arrivalEstimate];
        _arrivalEstimate = arrivalEstimate;
        
        if ([arrivalEstimate timeIntervalSinceNow] > 0) {
            self.state = NMDeliveryCountdownStateCounting;
        } else {
            self.state = NMDeliveryCountdownStateArrivingSoon;
        }
    }
}

#pragma mark - Update Delivery Times

- (void)startFetchingOrderStatus {
    _fetchOrderTimer = [NSTimer scheduledTimerWithTimeInterval:NMOrderFetchInterval target:self selector:@selector(fetchOrderStatus) userInfo:nil repeats:YES];
    [self fetchOrderStatus];
}

- (void)stopFetchingOrderStatus {
    [_fetchOrderTimer invalidate];
}

- (void)fetchOrderStatus {
    __block NMDeliveryTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"orders/%@", _order.uid] parameters:nil completion:^(OVCResponse *response, NSError *error) {
        
        __block NMOrderApiModel *orderModel = response.result;
        dispatch_async(dispatch_get_main_queue(), ^{
            this.order = [MTLManagedObjectAdapter managedObjectFromModel:orderModel insertingIntoContext:[NSManagedObjectContext MR_defaultContext] error:nil];
        });
    }];
}

#pragma mark - Cancel

- (void)cancel:(id)button {
    
    __block NMDeliveryTableViewController *this = self;

    if ([self.order.placedAt timeIntervalSinceNow] < -120) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Cannot cancel order" andMessage:@"Orders can't be cancelled after two minutes. If you need help, contact us"];
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tel:+11111"]]) {
            [alert addButtonWithTitle:@"Text Us" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
                        controller.subject = @"Nommit Support";
                        controller.recipients = @[@"+14152739617"];
                        [this presentViewController:controller animated:YES completion:nil];
                    });
            }];
        }
        [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
        
    } else {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Are you sure?" andMessage:@"Your courier is already on the way! Are you sure you want to cancel?"];
        [alert addButtonWithTitle:@"No" type:SIAlertViewButtonTypeCancel handler:NULL];
        [alert addButtonWithTitle:@"Yes" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
            
            [SVProgressHUD showWithStatus:@"Cancelling..." maskType:SVProgressHUDMaskTypeBlack];
            [[NMApi instance] PUT:[NSString stringWithFormat:@"orders/%@", _order.uid] parameters:@{ @"state_id" : @(NMOrderStateCancelled) }completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
                
                if (error) return;
                [SVProgressHUD showSuccessWithStatus:@"Cancelled!"];
                NMFoodsTableViewController *foodsVC = [[NMFoodsTableViewController alloc] init];
                NMNavigationController *nav = [[NMNavigationController alloc] initWithRootViewController:foodsVC];
                this.frostedViewController.contentViewController = nav;
                
            }];
            
        }];
        [alert show];
    }
}

@end
