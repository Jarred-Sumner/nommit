//
//  NMNotificationApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 11/20/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "MTLModel.h"

@interface NMSubscriptionApiModel : MTLModel<MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *sms;
@property (nonatomic, strong) NSNumber *email;
@property (nonatomic, strong) NSNumber *pushNotifications;

@end
