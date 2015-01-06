//
//  NMNoFoodTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 1/4/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMNoFoodViewState) {
    NMNoFoodViewStateUnknown = 0,
    NMNoFoodViewStateClosed
};

@interface NMNoFoodView : UIView

@property (nonatomic) NMNoFoodViewState state;

@end
