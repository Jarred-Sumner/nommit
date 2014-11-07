//
//  NMFoodTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
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

@interface NMFoodTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDate *arrivalTime;
@property (nonatomic, strong) UIButton *notifyButton;
@property (nonatomic, strong) MZTimerLabel *timerLabel;

@property (nonatomic) NMFoodCellState state;

- (void)setFood:(NMFood*)food arrivalTime:(NSDate*)arrivalTime;

- (void)setFutureSaleLayout;



@end
