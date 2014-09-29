//
//  NMFoodDeliveryPlaceApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/27/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodDeliveryPlaceApiModel.h"

@implementation NMFoodDeliveryPlaceApiModel

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"stateID" : @"state_id",
             @"waitInterval" : @"wait_interval"
             };
}

+ (NSValueTransformer *)etaJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)placeJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMPlaceApiModel class]];
}


+ (NSValueTransformer *)courierJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMCourierApiModel class]];
}

+ (NSValueTransformer *)foodJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMFoodApiModel class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMFoodDeliveryPlace";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"place" : [NMPlaceApiModel class],
             @"courier" : [NMCourierApiModel class],
             @"food" : [NMFoodApiModel class]
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

@end
