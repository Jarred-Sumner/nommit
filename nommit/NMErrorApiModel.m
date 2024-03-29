//
//  NMErrorApiModel.m
//  nommit
//
//  Created by Jarred Sumner on 9/23/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMErrorApiModel.h"
#import <SVProgressHUD.h>
#import <SIAlertView.h>
#import "NMAppDelegate.h"
#import "NMSession.h"

@implementation NMErrorApiModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey { return @{}; }

- (void)flashError {
    [SVProgressHUD dismiss];
    if (!_message) _message = @"Oops! Something broke. We've been notified. Please try again.";

    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"An error occurred" andMessage:_message];
    [alert  addButtonWithTitle:@"Okay"
            type:SIAlertViewButtonTypeDestructive
            handler:NULL];
    [alert show];
}

- (NSSet*)errorCodes {
    return [NSSet setWithObjects:@500, @400, @422, @403, @404, nil];
}

- (void)handleError {
    if (_status.integerValue == 401) {
        [NMSession logout];
        [self flashError];
    } else if ([[self errorCodes] member:_status]) [self flashError];
}

+ (void)handleGenericError {
    NMErrorApiModel *error = [[NMErrorApiModel alloc] init];
    error.status = @500;
    [error flashError];
}

@end
