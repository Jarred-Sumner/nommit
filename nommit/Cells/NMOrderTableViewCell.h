//
//  NMFoodOrderTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMOrderTableViewCellState) {
    NMOrderTableViewCellStatePending = 0,
    NMOrderTableViewCellStateDelivering
};

@interface NMOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) FBProfilePictureView *profileAvatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderName;
@property (nonatomic, strong) UIActivityIndicatorView *spinnerView;
@property (nonatomic) NMOrderTableViewCellState state;

@end
