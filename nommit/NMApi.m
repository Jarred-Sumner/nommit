//
//  NMApi.m
//  nommit
//
//  Created by Jarred Sumner on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"



static NSString *NMApiBaseURLString = @"http://getnommit.com";

@implementation NMApi

+ (NSURLSessionConfiguration *)sessionConfiguration {
    static NSURLSessionConfiguration *sessionConfig = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        if (NMSession.isUserLoggedIn) {
            sessionConfig.HTTPAdditionalHeaders = @{ @"X-SESSION-ID" : [NMSession sessionID] };
        }
    });
    return sessionConfig;
}

+ (NMApi *)instance {
    static NMApi *sharedApi = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedApi = [[NMApi alloc] initWithBaseURL:[NSURL URLWithString:NMApiBaseURLString] managedObjectContext:[NSManagedObjectContext MR_defaultContext] sessionConfiguration:NMApi.sessionConfiguration];
    });
    return sharedApi;
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"users/*" : [NMUserApiModel class],
             @"sessions" : [NMUserApiModel class],
             @"orders" : [NMOrderApiModel class],
             @"orders/*" : [NMOrderApiModel class],
             @"foods" : [NMFoodApiModel class]
     };
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    return dateFormatter;
}

@end
