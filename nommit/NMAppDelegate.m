//
//  NMAppDelegate.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAppDelegate.h"
#import "NMFoodsViewController.h"
#import "NMItemsCollectionViewController.h"

@interface NMAppDelegate () <UINavigationControllerDelegate>

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[NMFoodsViewController alloc] init]];
    self.window.rootViewController = navigationController;
    
    navigationController.navigationBar.translucent = NO;
    
    self.navigationController = navigationController;
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end
