//
//  NMFoodOrderTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import <MGSwipeButton.h>

typedef NS_ENUM(NSInteger, NMOrderTableViewCellState) {
    NMOrderTableViewCellStatePending = 0,
    NMOrderTableViewCellStateDelivering
};

@interface NMOrderTableViewCell : MGSwipeTableCell

@property (nonatomic, strong) MGSwipeButton *callButton;
@property (nonatomic, strong) MGSwipeButton *doneButton;
@property (nonatomic, strong) FBProfilePictureView *profileAvatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderName;

@end
