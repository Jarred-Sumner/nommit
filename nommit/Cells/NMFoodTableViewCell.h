//
//  NMFoodTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFood.h"
#import "MZTimerLabel.h"

typedef void (^NMFoodTableViewCellTimerBlock)(NSTimeInterval elapsed);

@interface NMFoodTableViewCell : UITableViewCell


@property (nonatomic) NMFoodState state;
@property (nonatomic) NMFoodQuantityState quantityState;
@property (nonatomic) NMFoodTimingState timingState;

@property (nonatomic, strong) UIImageView *featuredBadge;

- (void)setFood:(NMFood*)food;



@end
