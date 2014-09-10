//
//  NMAddressApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAddressApiModel.h"

@implementation NMAddressApiModel

#pragma mark - MTLJSONSerializing Protocol

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id",
             @"addressOne" : @"address_one",
             @"addressTwo" : @"address_two",
     };
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMAddress";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}


@end
