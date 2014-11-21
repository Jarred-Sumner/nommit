//
//  NMNotificationApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 11/20/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSubscriptionApiModel.h"

@implementation NMSubscriptionApiModel

#pragma mark - MTLJSONSerializing Implementation

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"uid" : @"id",
             @"pushNotifications" : @"push_notifications"
             };
}



#pragma mark - MTLManagedObjectSerializing Implementation

+ (NSString *)managedObjectEntityName {
    return @"NMSubscription";
}

+ (NSDictionary *)managedObjectKeysByPropertyKey {
    return @{};
}

+ (NSSet *)propertyKeysForManagedObjectUniquing {
    return [NSSet setWithObject:@"uid"];
}

@end
