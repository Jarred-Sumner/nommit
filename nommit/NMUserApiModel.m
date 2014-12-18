//
//  NMUserApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMUserApiModel.h"

@implementation NMUserApiModel

#pragma mark - MTLJSONSerializing

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"facebookUID": @"id",
             @"isCourier" : @"is_courier",
             @"referralCode" : @"referral_code",
             @"lastFour" : @"last_four",
             @"cardType" : @"card_type",
             @"paymentAuthorized" : @"payment_authorized",
             @"fullName" : @"full_name",
             @"stateID" : @"state_id",
             @"creditInCents" : @"credit_in_cents"
    };
}

+ (NSValueTransformer *)schoolJSONTransformer  {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:[NMSchoolApiModel class]];
}

#pragma mark - MTLManagedObjectSerializing

+ (NSString *)managedObjectEntityName {
    return @"NMUser";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSDictionary *)relationshipModelClassesByPropertyKey {
    return @{
             @"school" : [NMSchoolApiModel class]
             };
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"facebookUID"];
}


@end
