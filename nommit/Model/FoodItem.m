//
//  FoodItem.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "FoodItem.h"

@implementation FoodItem

@dynamic itemsSold;
@dynamic headerImage;
@dynamic price;
@dynamic itemName;
@dynamic itemsTotal;

- (id)initWithTotalItems:(NSUInteger)totalItems withPrice:(NSUInteger)price withName:(NSString *)name withImage:(UIImage *)headerImage {
    self.itemsTotal = totalItems;
    self.price = price;
    self.itemName = name;
    self.headerImage = headerImage;
    self.itemsSold = 0;
    return self;
}

@end
