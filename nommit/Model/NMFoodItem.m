//
//  FoodItem.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodItem.h"

@implementation NMFoodItem

@synthesize itemsSold, headerImage, price, itemName, description, itemsTotal;

//@dynamic itemsSold;
//@dynamic headerImage;
//@dynamic price;
//@dynamic itemName;
//@dynamic itemsTotal;
//@dynamic description;

- (id)initWithTotalItems:(NSUInteger)totalItems withPrice:(NSUInteger)price withName:(NSString *)name withDescription:(NSString *)description withImage:(UIImage *)headerImage withItemsSold:(NSUInteger)sold {
    self.itemsTotal = totalItems;
    self.price = price;
    self.itemName = name;
    self.headerImage = headerImage;
    self.itemsSold = sold;
    self.description = description;
    return self;
}


@end
