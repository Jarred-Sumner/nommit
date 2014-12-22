//
//  NMSession.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMSession.h"
#import <Lockbox.h>
#import "NMUser.h"
#import "NMAppDelegate.h"

static NSString *NMPushNotificationsKey = @"NMPushNotificationsKey";
static NSString *NMSessionIDKey = @"NMSessionIDKey";
static NSString *NMSessionUserIDKey = @"NMSessionUserIDKey";

@implementation NMSession

+ (BOOL)isUserLoggedIn {
    return self.sessionID && self.sessionID.length > 0 && [NMUser currentUser];
}

+ (NSString *)sessionID {
    return [Lockbox stringForKey:NMSessionIDKey];
}

+ (void)setSessionID:(NSString *)sessionID {
    [Lockbox setString:sessionID forKey:NMSessionIDKey];
}

+ (BOOL)hasRequestedPush {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:NMPushNotificationsKey] boolValue];
}

+ (void)setRequestedPush:(BOOL)requestedPush {
    [[NSUserDefaults standardUserDefaults] setObject:@(requestedPush) forKey:NMPushNotificationsKey];
}

+ (NSString *)userID {
    NSString *userID = [Lockbox stringForKey:NMSessionUserIDKey];
    if (userID.length > 0) {
        [[Mixpanel sharedInstance] identify:userID];
    }
    return userID;
}

+ (void)setUserID:(NSString *)userID {
    [Lockbox setString:userID forKey:NMSessionUserIDKey];
    [NMUser setCurrentUser:[NMUser MR_findFirstByAttribute:@"facebookUID" withValue:userID]];
}

+ (void)logout {
    [MagicalRecord saveUsingCurrentThreadContextWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        [NMUser MR_truncateAllInContext:localContext];
        [NMShift MR_truncateAllInContext:localContext];
        [NMOrder MR_truncateAllInContext:localContext];
        [NMDeliveryPlace MR_truncateAllInContext:localContext];
        [NMCourier MR_truncateAllInContext:localContext];
        [NMPlace MR_truncateAllInContext:localContext];
        [NMPrice MR_truncateAllInContext:localContext];
        [NMFood MR_truncateAllInContext:localContext];
        [NMSeller MR_truncateAllInContext:localContext];
        [NMLocation MR_truncateAllInContext:localContext];
    }];

    [NMSession setSessionID:nil];
    [NMSession setUserID:nil];
    [NMPlace setActivePlace:nil];
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession setActiveSession:nil];
    [(NMAppDelegate*)[[UIApplication sharedApplication] delegate] resetUI];
}
@end
