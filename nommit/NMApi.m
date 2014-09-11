//
//  NMApi.m
//  nommit
//
//  Created by Jarred Sumner on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"


@implementation NMApi

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"users/*" : [NMUserApiModel class],
             @"sessions" : [NMUserApiModel class],
//             @"orders" : [NMOrderApiModel class],
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
