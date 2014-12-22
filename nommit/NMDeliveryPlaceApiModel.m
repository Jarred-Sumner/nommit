//
//  NMDeliveryPlaceApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMDeliveryPlaceApiModel.h"

@interface NMDeliveryPlaceApiModel () {
    NSMutableDictionary *_orders;
}

@property (readonly) NSMutableDictionary *ordersDict;

@end

@implementation NMDeliveryPlaceApiModel

- (NSMutableDictionary*)ordersDict {
    if (!_orders) {
        _orders = [[NSMutableDictionary alloc] init];
    }
    return _orders;
}

- (NSArray*)orders {
    return [self.ordersDict allValues];
}

- (void)addOrder:(NMOrderApiModel*)order {
    [self.ordersDict setObject:order forKey:order.uid];
}

- (void)removeOrder:(NMOrderApiModel*)order {
    [self.ordersDict removeObjectForKey:order.uid];
}

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"stateID" : @"state_id",
             @"arrivesAt" : @"arrives_at",
             };
}

+ (NSValueTransformer *)foodsJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMFoodApiModel class]];
}

+ (NSValueTransformer *)placeJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMPlaceApiModel class]];
}

+ (NSValueTransformer *)arrivesAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NMApi.dateFormatter dateFromString:str];
    } reverseBlock:^(NSDate *date) {
        return [NMApi.dateFormatter stringFromDate:date];
    }];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMDeliveryPlace";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{
        @"places": NSNull.null,
        @"orders" : NSNull.null,
    };
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
         @"foods" : [NMFoodApiModel class],
         @"place" : [NMPlaceApiModel class],
    };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

@end
