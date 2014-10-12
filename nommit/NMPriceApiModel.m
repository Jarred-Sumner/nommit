//
//  NMPriceApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 10/11/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPriceApiModel.h"

@implementation NMPriceApiModel

#pragma mark - MTLJSONSerializing Implementation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id"
    };
}



#pragma mark - MTLManagedObjectSerializing Implementation

+ (NSString *)managedObjectEntityName {
    return @"NMPrice";
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
        @"food" : [NMFoodApiModel class]
    };
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


@end
