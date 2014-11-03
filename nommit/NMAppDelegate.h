//
//  NMAppDelegate.h
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <REFrostedViewController.h>
#import "NMMenuNavigationController.h"


@interface NMAppDelegate : UIResponder <UIApplicationDelegate, REFrostedViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly) UIViewController *rootViewController;

- (void)registerForPushNotifications;
- (void)resetUI;

@end
