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

typedef NS_ENUM(NSInteger, NMFoodCellState) {
    NMFoodCellStateSoldOut = 1,
    NMFoodCellStateExpired,
    NMFoodCellStateFuture,
    NMFoodCellStateNormal
};

typedef void (^NMFoodTableViewCellTimerBlock)(NSTimeInterval elapsed);

@interface NMFoodTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *startTimeLabel;

@property (nonatomic) NMFoodCellState state;

- (void)setFood:(NMFood*)food;



@end
