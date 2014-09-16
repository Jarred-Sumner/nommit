//
//  NMApi.h
//  nommit
//
//  Created by Jarred Sumner on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Overcoat.h>

#import "NMFoodApiModel.h"
#import "NMOrderApiModel.h"
#import "NMUserApiModel.h"
#import "NMAddressApiModel.h"

#import "NMAddress.h"
#import "NMFood.h"
#import "NMorder.h"
#import "NMUser.h"

#import "NMSession.h"

@interface NMApi : OVCHTTPSessionManager

+ (NMApi *)instance;
+ (NSDateFormatter *)dateFormatter;

@end
