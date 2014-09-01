//
//  NMOrderFoodView.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFoodItem.h"

@interface NMOrderFoodView : UIView

@property (nonatomic, strong) NMFoodItem *foodItem;

- (id)initWithFrame:(CGRect)frame initWithFoodItem:(NMFoodItem *)foodItem;

@end
