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
        @"discountInCents" : @"discount_in_cents",
        @"deliveredAt" : @"delivered_at",
        @"placedAt" : @"created_at",
        @"stateID" : @"state_id",
        @"chargeStateID" : @"charge_state_id",
        @"promoCode" : @"promo_code",
        @"confirmed": NSNull.null
     };
}

+ (NSValueTransformer *)placedAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)deliveredAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

+ (NSValueTransformer *)userJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:NMUserApiModel.class];
}

+ (NSValueTransformer *)placeJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMPlaceApiModel class]];

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

#pragma mark - Validations

- (BOOL)isValid {
    return self.confirmed.boolValue && self.place && self.food.isActive;
}
    
@end
