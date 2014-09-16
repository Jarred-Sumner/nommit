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
#import <REFrostedViewController.h>
#import <REFrostedContainerViewController.h>
#import "NMMenuNavigationController.h"
#import "NMMenuViewController.h"
#import "NMMenuNavigationController.h"
#import "NMLoginViewController.h"

#import "CoreData+MagicalRecord.h"
#import <MagicalRecord+ShorthandSupport.h>
#import <FacebookSDK/FacebookSDK.h>

@interface NMAppDelegate ()

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupAutoMigratingCoreDataStack];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // create content and menu controllers
    NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:self.rootViewController];
    NMMenuViewController *menuController = [[NMMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:navigationController menuViewController:menuController];
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // make it root view controller
    self.window.rootViewController = frostedViewController;
    
    navigationController.navigationBar.translucent = NO;
    
    self.navigationController = navigationController;
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x42B7BB)];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

- (UIViewController *)rootViewController {
    if ([NMSession isUserLoggedIn]) {
        return [[NMFoodsViewController alloc] init];
    } else return [[NMLoginViewController alloc] init];
}

#pragma mark - Facebook Login



// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
// Override application:openURL:sourceApplication:annotation to call the FBsession object that handles the incoming URL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}

@end
