//
//  NMOrderApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
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
        @"tipInCents" : @"tip_in_cents",
        @"deliveredAt" : @"delivered_at",
        @"placedAt" : @"created_at",
        @"stateID" : @"state_id",
        @"chargeStateID" : @"charge_state_id",
        @"promoCode" : @"promo_code",
        @"priceChargedInCents" : @"price_charged_in_cents",
        @"deliveryPlace" : @"delivery_place"
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

+ (NSValueTransformer *)deliveryPlaceJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:NMDeliveryPlaceApiModel.class];
}

+ (NSValueTransformer *)courierJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMCourierApiModel class]];
}

+ (NSValueTransformer *)foodJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMFoodApiModel class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMOrder";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
             @"deliveryPlace" : NSNull.null
    };
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"food" : [NMFoodApiModel class],
             @"place" : [NMPlaceApiModel class],
             @"user" : [NMUserApiModel class],
             @"courier" : [NMCourierApiModel class]
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

#pragma mark - Create Params

- (NSDictionary*)createParamsWithFood:(NMFood*)food place:(NMPlace*)place {
    if (!_promoCode) _promoCode = @"";
    if (!_quantity || _quantity.integerValue < 1) _quantity = @1;
    return @{
             @"price_id" : [NMPrice priceIDForFood:food quantity:_quantity],
             @"promo_code" : _promoCode,
             @"place_id" : place.uid,
             @"food_id" : food.uid
             };
}

@end
