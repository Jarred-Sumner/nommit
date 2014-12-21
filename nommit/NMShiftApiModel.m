//
//  NMShiftApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMShiftApiModel.h"

@interface NMShiftApiModel ()

@end

@implementation NMShiftApiModel

- (NSArray*)activeDeliveryPlaces {
    NSMutableDictionary *dps = [[NSMutableDictionary alloc] init];
    for (NMOrderApiModel *order in self.orders) {
        dps[order.deliveryPlace.uid] = dps[order.deliveryPlace];
        [order.deliveryPlace.orders addObject:order];
    }
    return dps.allValues;
}


#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"stateID" : @"state_id",
             @"revenueGeneratedInCents" : @"revenue_generated_in_cents",
             @"places" : NSNull.null,
             @"orders" : NSNull.null
             };
}

+ (NSValueTransformer *)courierJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMCourierApiModel class]];
}

+ (NSValueTransformer *)ordersJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMOrderApiModel class]];
}


#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMShift";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"courier" : [NMCourierApiModel class],
    };
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


@end
