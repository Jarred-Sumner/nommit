//
//  NMAppDelegate.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAppDelegate.h"
#import "NMItemsCollectionViewController.h"
#import <REFrostedViewController.h>
#import <REFrostedContainerViewController.h>
#import "NMMenuNavigationController.h"
#import "NMMenuViewController.h"
#import "NMMenuNavigationController.h"
#import "NMLoginViewController.h"
#import "NMFoodsTableViewController.h"
#import "NMActivateAccountTableViewController.h"
#import "NMRateOrderTableViewController.h"
#import <Crashlytics/Crashlytics.h>

@interface NMAppDelegate ()

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Crashlytics startWithAPIKey:@"31fe8f31e5f07653f483f7db9bf622029dd41d84"];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [self resetUI];
    
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x42B7BB)];

    if ([NMSession isUserLoggedIn]) {
        [self checkForActiveOrders];
    }
    
    return YES;
}

- (void)checkForActiveOrders {
    __block NMAppDelegate *this = self;
    [[NMApi instance] GET:@"orders" parameters:nil completion:^(OVCResponse *response, NSError *error) {
        
        if ([[NMUser currentUser] hasOrdersPendingRating]) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@ and stateID = %@", NMUser.currentUser, @(NMOrderStateDelivered)];
            NMOrder *order = [NMOrder MR_findFirstWithPredicate:predicate];
            
            if (order) {
                NMRateOrderTableViewController *rateVC = [[NMRateOrderTableViewController alloc] initWithOrder:order];
                
                [this.window.rootViewController presentViewController:rateVC animated:YES completion:NULL];
            }

        }
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [MagicalRecord cleanUp];
}

- (UIViewController *)rootViewController {
    if ([NMSession isUserLoggedIn]) {
        if ([NMUser currentUser].state == NMUserStateRegistered) {
            
            NMActivateAccountTableViewController *accountVC = [[NMActivateAccountTableViewController alloc] init];
            return accountVC;
            
        } else if ([NMUser currentUser].state == NMUserStateActivated) {
            
            return [[NMFoodsTableViewController alloc] init];
        } else return nil;
        
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

#pragma mark - UI Initialization

- (void)resetUI
{
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
}

- (UIWindow*)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}

@end
