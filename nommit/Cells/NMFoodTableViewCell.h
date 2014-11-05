//
//  NMFoodTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFood.h"

typedef NS_ENUM(NSInteger, NMFoodCellState) {
    NMFoodStateSoldOut = 1,
    NMFoodStateStopped = 2,
    NMFoodStateFuture = 3,
    NMFoodStateNormal = 4
};

@interface NMFoodTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDate *arrivalTime;

- (void)setFood:(NMFood*)food arrivalTime:(NSDate*)arrivalTime;

@end
