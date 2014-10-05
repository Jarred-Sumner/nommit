//
//  NMPlaceApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/20/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPlaceApiModel.h"

@implementation NMPlaceApiModel

+ (NSArray *)placesForModels:(NSArray *)models {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    NSError *error;
    for (NMPlaceApiModel *placeApiModel in models) {
        NMPlace *place = [MTLManagedObjectAdapter managedObjectFromModel:placeApiModel insertingIntoContext:[[NMApi instance] managedObjectContext] error:&error];
        [places addObject:place];
        NSLog(@"Error: %@", error);
        NSLog(@"Place: %@", placeApiModel.name);
    }
    return places;
}

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"foodCount" : @"food_count",
             @"deliveryPlaces" : @"delivery_places"
    };
}


+ (NSValueTransformer *)locationJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMLocationApiModel class]];
}

+ (NSValueTransformer *)deliveryPlacesJSONTransformer  {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[NMDeliveryPlaceApiModel class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMPlace";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"foods" : [NMFoodApiModel class],
             @"orders" : [NMOrderApiModel class],
             @"couriers" : [NMCourierApiModel class],
             @"location" : [NMLocationApiModel class],
             @"deliveryPlaces" : [NMDeliveryPlaceApiModel class]
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

@end
