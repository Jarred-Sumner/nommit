//
//  NMFoodApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodApiModel.h"

@implementation NMFoodApiModel

+ (NSArray *)foodsForModels:(NSArray *)models {
    NSMutableArray *foods = [[NSMutableArray alloc] init];
    
    NSError *error;
    for (NMFoodApiModel *foodApiModel in models) {
        NMFood *food = [MTLManagedObjectAdapter managedObjectFromModel:foodApiModel insertingIntoContext:[NSManagedObjectContext MR_defaultContext] error:&error];
        [foods addObject:food];
        NSLog(@"Error: %@", error);
        NSLog(@"Food: %@", foodApiModel.title);
    }
    return foods;
}

#pragma mark - MTLJSONSerializing Protocol

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id",
             @"subtitle" : @"place",
             @"stateID" : @"state_id",
             @"endDate" : @"end_date",
             @"headerImageURL" : @"header_image_url",
             @"thumbnailImageURL" : @"thumbnail_image_url",
             @"orderGoal": @"goal",
             @"orderCount" : @"order_count",
             @"details" : @"description",
    };
}

+ (NSValueTransformer *)endDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMFood";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
             @"title" : @"title"};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}




@end
