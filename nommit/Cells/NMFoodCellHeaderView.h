//
//  NMFoodCellHeaderView.h
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"

@interface NMFoodCellHeaderView : UIView
@property (nonatomic, strong) RateView *rateVw;
@property (strong, nonatomic) UIImageView *profileAvatar;
@property (strong, nonatomic) UILabel *nameLabel;

@end
