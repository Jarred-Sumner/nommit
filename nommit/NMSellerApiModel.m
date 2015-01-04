//
//  NMSellerApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/20/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMSellerApiModel.h"

@implementation NMSellerApiModel

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid": @"id",
             @"logoURL" : @"logo_url"
             };
}

+ (NSValueTransformer *)schoolJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMSchoolApiModel class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMSeller";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"foods" : [NMFoodApiModel class],
             @"couriers" : [NMCourierApiModel class],
             @"school" : [NMSchoolApiModel class]
     };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

@end
