//
//  NMSession.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMSession : NSObject

+ (BOOL)isUserLoggedIn;

+ (NSString *)sessionID;
+ (void)setSessionID:(NSString *)sessionID;

+ (NSString *)userID;
+ (void)setUserID:(NSString *)userID;

+ (BOOL)hasRequestedPush;
+ (void)setRequestedPush:(BOOL)requestedPush;

+ (void)logout;

@end
