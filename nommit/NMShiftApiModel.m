//
//  NMShiftApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMShiftApiModel.h"

@implementation NMShiftApiModel

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"stateID" : @"state_id",
             @"deliveryPlaces" : @"delivery_places",
             @"places" : NSNull.null
             };
}

+ (NSValueTransformer *)courierJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMCourierApiModel class]];
}

+ (NSValueTransformer *)deliveryPlacesJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMDeliveryPlaceApiModel class]];
}


#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMShift";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"courier" : [NMCourierApiModel class],
             @"deliveryPlaces" : [NMDeliveryPlaceApiModel class],
             };
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


@end
