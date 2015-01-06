//
//  NMNoFoodTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 1/4/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMNoFoodCellState) {
    NMNoFoodCellStateUnknown = 0,
    NMNoFoodCellStateClosed
};

@interface NMNoFoodTableViewCell : UITableViewCell

@property (nonatomic) NMNoFoodCellState state;

@end
