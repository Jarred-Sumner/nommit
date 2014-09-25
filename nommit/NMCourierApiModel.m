//
//  NMCourierApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCourierApiModel.h"

@implementation NMCourierApiModel

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"stateID" : @"state_id"
             };
}

+ (NSValueTransformer *)placesJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMPlaceApiModel class]];
}


+ (NSValueTransformer *)userJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMUserApiModel class]];
}

+ (NSValueTransformer *)sellerJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMSellerApiModel class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMCourier";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"places" : [NMPlaceApiModel class],
             @"seller" : [NMSellerApiModel class],
             @"user" : [NMUserApiModel class]
     };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


@end
