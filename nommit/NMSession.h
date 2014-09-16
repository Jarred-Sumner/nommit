//
//  NMSession.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMSession : NSObject

+ (BOOL)isUserLoggedIn;

+ (NSString *)accessToken;
+ (void)setAccessToken:(NSString *)accessToken;

+ (NSString *)userID;
+ (void)setUserID:(NSString *)userID;

@end