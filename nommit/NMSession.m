//
//  NMSession.m
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSession.h"
#import <Lockbox.h>

static NSString *NMSessionAccessTokenKey = @"NMSessionAccessTokenKey";
static NSString *NMSessionUserIDKey = @"NMSessionUserIDKey";

@implementation NMSession

+ (BOOL)isUserLoggedIn {
    return [self accessToken].length > 0;
}

+ (NSString *)accessToken {
    return [Lockbox stringForKey:NMSessionAccessTokenKey];
}

+ (void)setAccessToken:(NSString *)accessToken {
    [Lockbox setString:accessToken forKey:NMSessionAccessTokenKey];
}

+ (NSString *)userID {
    return [Lockbox stringForKey:NMSessionUserIDKey];
}

+ (void)setUserID:(NSString *)userID {
    [Lockbox setString:userID forKey:NMSessionUserIDKey];
}
@end
