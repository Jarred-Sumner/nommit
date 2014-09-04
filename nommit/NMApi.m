//
//  NMApi.m
//  nommit
//
//  Created by Jarred Sumner on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"

#import "NMUser.h"
#import "NMOrder.h"
#import "NMFood.h"

@implementation NMApi

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"users/*" : [NMUser class],
             @"sessions/*" : [NMUser class],
             @"orders/*" : [NMOrder class]
     };
}

@end
