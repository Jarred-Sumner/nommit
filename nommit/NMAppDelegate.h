//
//  NMAppDelegate.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>
#import "NMNavigationController.h"

static NSString *NMDidRegisterForPushNotificationsKey = @"RegisteredForPush";
static NSString *NMDidFailToRegisterForPushNotificationsKey = @"FailedToRegisterForPush";

@interface NMAppDelegate : UIResponder <UIApplicationDelegate, REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) UIViewController *rootViewController;

- (BOOL)isPushEnabled;
- (void)registerForPushNotifications;
- (void)resetUI;

@end
