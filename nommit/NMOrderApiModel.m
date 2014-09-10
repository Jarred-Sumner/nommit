//
//  NMOrderApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderApiModel.h"

@implementation NMOrderApiModel

#pragma mark - MTLJSONSerializing Protocol

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id",
             @"priceInCents" : @"price_in_cents",
             @"createdAt" : @"created_at",
             @"placedAt" : @"placed_at",
             @"rawState" : @"state"
     };
}

+ (NSValueTransformer *)placedAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMUserApiModel class]];
}

+ (NSValueTransformer *)addressJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMAddressApiModel class]];

}

+ (NSValueTransformer *)foodJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMFoodApiModel class]];

}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMOrder";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

@end
