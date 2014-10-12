//
//  NMFoodApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodApiModel.h"

@implementation NMFoodApiModel

#pragma mark - MTLJSONSerializing Protocol

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id",
             @"subtitle" : @"place",
             @"stateID" : @"state_id",
             @"startDate" : @"start_date",
             @"endDate" : @"end_date",
             @"headerImageURL" : @"header_image_url",
             @"thumbnailImageURL" : @"thumbnail_image_url",
             @"orderGoal": @"goal",
             @"orderCount" : @"order_count",
             @"details" : @"description",
    };
}

+ (NSValueTransformer *)pricesJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMPriceApiModel class]];
}

+ (NSValueTransformer *)sellerJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMSellerApiModel class]];
}

+ (NSValueTransformer *)startDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
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
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"seller" : [NMSellerApiModel class],
             @"prices" : [NMPriceApiModel class]
    };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


#pragma mark - Utility Methods

- (BOOL)isActive {
    return [[self backingFood] isActive];
}

- (NMFood*)backingFood {
    return [NMFood MR_findFirstByAttribute:@"uid" withValue:self.uid];
}



@end
