//
//  NMSession.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSession.h"
#import <Lockbox.h>
#import "NMUser.h"
#import "NMAppDelegate.h"

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

+ (NSString *)userID {
    return [Lockbox stringForKey:NMSessionUserIDKey];
}

+ (void)setUserID:(NSString *)userID {
    [Lockbox setString:[NSString stringWithFormat:@"%@", userID] forKey:NMSessionUserIDKey];
    [NMUser setCurrentUser:[NMUser MR_findFirstByAttribute:@"facebookUID" withValue:userID]];
}

+ (void)logout {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [NMUser MR_truncateAllInContext:localContext];
        [NMShift MR_truncateAllInContext:localContext];
        [NMOrder MR_truncateAllInContext:localContext];
        [NMDeliveryPlace MR_truncateAllInContext:localContext];
        [NMCourier MR_truncateAllInContext:localContext];
        [NMPlace MR_truncateAllInContext:localContext];
        [NMFood MR_truncateAllInContext:localContext];
        [NMSeller MR_truncateAllInContext:localContext];
        [NMLocation MR_truncateAllInContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        [NMSession setSessionID:nil];
        [NMSession setUserID:nil];
        
        [(NMAppDelegate*)[[UIApplication sharedApplication] delegate] resetUI];
    }];
    
}
@end
