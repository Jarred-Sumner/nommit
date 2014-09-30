//
//  NMRateTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRateTableViewController.h"
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

@interface NMRateTableViewController ()<APParallaxViewDelegate>

@property (nonatomic, strong) NMOrder *order;
@property (nonatomic, strong) NMDeliveryAvatarsTableViewCell *avatarsCell;
@property (nonatomic, strong) NMDeliveryCallButtonTableViewCell *callButtonCell;
@property (nonatomic, strong) NMReceiptTableViewCell *receiptCell;
@property (nonatomic) NSInteger totalAmount;

@end

@implementation NMRateTableViewController

const NSInteger NMRateAvatarsSection = 0;
const NSInteger NMRateReceiptSection = 1;
const NSInteger NMRateCallButtonSection = 2;

static NSString *NMRateAvatarsInfoIdentifier = @"NMDeliveryAvatarsTableViewCell";
static NSString *NMRateReceiptInfoIdentifier = @"NMReceiptTableViewCell";
static NSString *NMRateDoneButtonInfoIdentifier = @"NMDeliveryDoneButtonTableViewCell";

- (id)initWithOrder:(NMOrder *)order {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _order = order;
        int price = (int)[_order.priceInCents integerValue]/100;
        _totalAmount = price;
        
        [self.tableView addParallaxWithImage:nil andHeight:90];
        [self.tableView.parallaxView setDelegate:self];
        [self.tableView.parallaxView.imageView setImageWithURL:order.food.headerImageAsURL];
//        [self.tableView addBlackOverlayToParallaxView];
        
        // register table view cells
        [self.tableView registerClass:[NMDeliveryAvatarsTableViewCell class] forCellReuseIdentifier:NMRateAvatarsInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCallButtonTableViewCell class] forCellReuseIdentifier:NMRateDoneButtonInfoIdentifier];
        [self.tableView registerClass:[NMReceiptTableViewCell class] forCellReuseIdentifier:NMRateReceiptInfoIdentifier];
        
        [self initNavBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [_avatarsCell.avatarSeller setImageWithURL:_order.food.seller.logoAsURL];
        return _avatarsCell;
    } else if (indexPath.section == NMRateReceiptSection) {
        _receiptCell = [self.tableView dequeueReusableCellWithIdentifier:NMRateReceiptInfoIdentifier];
        [_receiptCell.plusButton addTarget:self action:@selector(addOneToTip) forControlEvents:UIControlEventTouchUpInside];
        [_receiptCell.minusButton addTarget:self action:@selector(minusOneFromTip) forControlEvents:UIControlEventTouchUpInside];
        _receiptCell.tipLabel.text = [NSString stringWithFormat:@"$%d", _totalAmount];
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
    if (_totalAmount > (int)[_order.priceInCents integerValue]/100) {
        _receiptCell.minusButton.alpha = 1.0f;
        _receiptCell.minusButton.enabled = YES;
    } else {
        _receiptCell.minusButton.alpha = 0.5f;
        _receiptCell.minusButton.enabled = NO;
    }
}

- (void)addOneToTip {
    _totalAmount++;
    _receiptCell.tipLabel.text = [NSString stringWithFormat:@"$%d", _totalAmount];
    [self enableMinusButton];
}

- (void)minusOneFromTip {
    _totalAmount--;
    _receiptCell.tipLabel.text = [NSString stringWithFormat:@"$%d", _totalAmount];
    [self enableMinusButton];
}

- (void)done
{
    // TODO : DOSOMETHING WITH RATING
    float rating = _receiptCell.rateVw.rating;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)prefersStatusBarHidden { return YES; }


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


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
