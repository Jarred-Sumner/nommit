//
//  NMShiftApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMShiftApiModel.h"

@interface NMShiftApiModel () {
    NSMutableDictionary *_dps;
}

@end

@implementation NMShiftApiModel

- (NSArray*)activeDeliveryPlaces {
    if (!_dps) _dps = [[NSMutableDictionary alloc] init];

    for (NMOrderApiModel *order in self.orders) {
        NMDeliveryPlaceApiModel *dp = _dps[order.deliveryPlace.uid];
        if (!_dps[order.deliveryPlace.uid]) {
            [_dps setObject:order.deliveryPlace forKey:order.deliveryPlace.uid];
            dp = order.deliveryPlace;
        }

        dp.index = order.deliveryPlace.index;
        dp.arrivesAt = order.deliveryPlace.arrivesAt;
        dp.stateID = order.deliveryPlace.stateID;

        [dp addOrder:order];
    }
    return [_dps.allValues sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"index" ascending:YES]]];
}

- (void)removeOrder:(NMOrderApiModel*)order {
    id toBeRemoved;
    for (NMOrderApiModel *currentOrder in self.orders) {
        if ([currentOrder.uid isEqualToNumber:order.uid]) {
            toBeRemoved = currentOrder;
        }
    }
    [self.orders removeObject:toBeRemoved];
    [_dps[order.deliveryPlace.uid] removeOrder:order];
    
    if ([[_dps[order.deliveryPlace.uid] orders] count] == 0) {
        [_dps removeObjectForKey:order.deliveryPlace.uid];
    }
}


#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"stateID" : @"state_id",
             @"revenueGeneratedInCents" : @"revenue_generated_in_cents",
             @"places" : NSNull.null,
             @"placeIDs" : @"place_ids"
     };
}

+ (NSValueTransformer *)courierJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMCourierApiModel class]];
}

+ (NSValueTransformer *)ordersJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMOrderApiModel class]];
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
    };
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
             @"placeIDs" : NSNull.null
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


@end
