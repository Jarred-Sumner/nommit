//
//  NMCourierSummaryTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCourierSummaryTableViewController.h"
#import "UIScrollView+NMParallaxHeader.h"
#import "NMDeliveryAvatarsTableViewCell.h"
#import "NMDeliveryCallButtonTableViewCell.h"
#import "NMCourierSummaryTableViewCell.h"

@interface NMCourierSummaryTableViewController()<APParallaxViewDelegate>

@property (nonatomic, strong) NMShift *shift;
@property (nonatomic, strong) NMDeliveryAvatarsTableViewCell *avatarsCell;
@property (nonatomic, strong) NMDeliveryCallButtonTableViewCell *doneCell;

@end

@implementation NMCourierSummaryTableViewController

const NSInteger NMCourierAvatarsSection = 0;
const NSInteger NMCourierSummarySection = 1;
const NSInteger NMCourierDoneButtonSection = 2;

static NSString *NMCourierAvatarsInfoIdentifier = @"NMCourierAvatarsTableViewCell";
static NSString *NMCourierDoneButtonInfoIdentifier = @"NMCourierDoneButtonTableViewCell";
static NSString *NMCourierSummaryIdentifier = @"NMCourierSummaryTableViewCell";

- (id)initWithShift:(NMShift *)shift {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _shift = shift;
        
        [self.tableView addParallaxWithImage:nil andHeight:150];
        [self.tableView.parallaxView setDelegate:self];
        // TODO: PLACEHOLDER FOR THIS SHIT
        [self.tableView.parallaxView.imageView setImage:[UIImage imageNamed: @"LoadingImage"]];
        [self.tableView addBlackOverlayToParallaxView];
        
        
        // register table view cells
        [self.tableView registerClass:[NMDeliveryAvatarsTableViewCell class] forCellReuseIdentifier:NMCourierAvatarsInfoIdentifier];
        [self.tableView registerClass:[NMDeliveryCallButtonTableViewCell class] forCellReuseIdentifier:NMCourierDoneButtonInfoIdentifier];
        [self.tableView registerClass:[NMCourierSummaryTableViewCell class] forCellReuseIdentifier:NMCourierSummaryIdentifier];
        
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
    if (section == NMCourierAvatarsSection) {
        return 1;
    } else if (section == NMCourierSummarySection) {
        return 3;
    } else if (section == NMCourierDoneButtonSection) {
        return 1;
    }
    else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // make total 354
    if (indexPath.section == NMCourierAvatarsSection) {
        return 120;
    } else if (indexPath.section == NMCourierSummarySection) {
        return 63;
    } else if (indexPath.section == NMCourierDoneButtonSection) {
        return 48;
    } return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMCourierAvatarsSection) {
        _avatarsCell = [self.tableView dequeueReusableCellWithIdentifier:NMCourierAvatarsInfoIdentifier];
        _avatarsCell.priceLabel.text = [NSString stringWithFormat:@"$%d", 210];
        _avatarsCell.updateLabel.text = [NSString stringWithFormat:@"You worked %d hours and made $%d on behalf of %@ ", 3, 210, @"Delta Delta Delta"];
        [_avatarsCell setupCourierAvatarWithProfileId:_shift.courier.user.facebookUID];
        [_avatarsCell.avatarSeller setImageWithURL:_shift.courier.seller.logoAsURL placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
        return _avatarsCell;
    } else if (indexPath.section == NMCourierSummarySection) {
        NMCourierSummaryTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMCourierSummaryIdentifier];
        if (indexPath.row == 0 || indexPath.row == 1) {
            cell.amountLabel.text = @"25";
            cell.subtitleLabel.text = @"sugar cookies sold";
            cell.iconImageView.image = [UIImage imageNamed:@"Takeout"];
        } else {
            cell.amountLabel.text = @"20";
            cell.subtitleLabel.text = @"deliveries made";
            cell.iconImageView.image = [UIImage imageNamed:@"PersonIcon"];
        }
        
        return cell;
    } else if (indexPath.section == NMCourierDoneButtonSection) {
        _doneCell = [self.tableView dequeueReusableCellWithIdentifier:NMCourierDoneButtonInfoIdentifier];
        [_doneCell.callButton addTarget:self action:@selector(donePressed) forControlEvents:UIControlEventTouchUpInside];
        [_doneCell.callButton setTitle:@"Done" forState:UIControlStateNormal];
        return _doneCell;
    }
    return nil;
}

- (void)donePressed
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initNavBar
{
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 86.5*1.3, 21*1.3)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(15, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    self.navigationController.navigationBarHidden = NO;
    
}





@end
