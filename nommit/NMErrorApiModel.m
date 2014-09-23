//
//  NMErrorApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/23/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMErrorApiModel.h"
#import <SVProgressHUD.h>
#import "NMAppDelegate.h"

@implementation NMErrorApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey { return @{}; }

- (void)flashError {
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD showErrorWithStatus:_message];
}

- (void)handleError {
    if (_status.integerValue == 401) {
        [NMSession setSessionID:nil];
        [NMSession setUserID:nil];
        
        [(NMAppDelegate*)[[UIApplication sharedApplication] delegate] resetUI];
        [self flashError];
    } else if (_status.integerValue == 500) [self flashError];
}

@end
