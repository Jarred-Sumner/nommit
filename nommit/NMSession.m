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

static NSString *NMSessionIDKey = @"NMSessionIDKey";
static NSString *NMSessionUserIDKey = @"NMSessionUserIDKey";

@implementation NMSession

+ (BOOL)isUserLoggedIn {
    return self.sessionID && self.sessionID.length > 0;
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
@end
