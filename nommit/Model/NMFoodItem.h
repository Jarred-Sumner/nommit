//
//  FoodItem.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMFoodItem : NSObject

@property (nonatomic, strong) UIImage *headerImage;
@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *description;
@property (nonatomic) NSUInteger price;
@property (nonatomic) NSUInteger itemsSold;
@property (nonatomic) NSUInteger itemsTotal;

- (id)initWithTotalItems:(NSUInteger)totalItems withPrice:(NSUInteger)price withName:(NSString *)name withDescription:(NSString *)description withImage:(UIImage *)headerImage withItemsSold:(NSUInteger)sold;

@end