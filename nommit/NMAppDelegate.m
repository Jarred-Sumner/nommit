//
//  NMAppDelegate.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAppDelegate.h"
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

static NSString *NMPushNotificationsKey = @"NMPushNotificationsKey";

@interface NMAppDelegate ()

@property (nonatomic, strong) NMMenuNavigationController *navigationController;

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBLoginView class];
    [Crashlytics startWithAPIKey:@"31fe8f31e5f07653f483f7db9bf622029dd41d84"];
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
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
    [[NMApi instance] GET:@"orders" parameters:nil completion:NULL];
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

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}

- (void)handleSessionStateChange:(FBSession*)session {

}

#pragma mark - UI Initialization

- (void)resetUI
{
    // create content and menu controllers
    _navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:self.rootViewController];
    NMMenuViewController *menuController = [[NMMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:_navigationController menuViewController:menuController];
    
    frostedViewController.direction = REFrostedViewControllerDirectionLeft;
    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    frostedViewController.liveBlur = YES;
    frostedViewController.delegate = self;
    
    // make it root view controller
    self.window.rootViewController = frostedViewController;

    _navigationController.navigationBar.translucent = NO;
}

- (UIWindow*)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return _window;
}

#pragma mark - Push Notifications

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"Push Notifications with Token: %@", devToken);
    NSString *token = [devToken base64EncodedStringWithOptions:0];
    [[NMApi instance] POST:@"devices" parameters:@{ @"token" : token }  completion:NULL];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void)registerForPushNotifications {
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:NMPushNotificationsKey] boolValue]) return;
    
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Find out when food is available" andMessage:@"To get notified when food is available, please enable push notifications"];
    
    [alert addButtonWithTitle:@"Cancel" type:SIAlertViewButtonTypeCancel handler:NULL];
    [alert addButtonWithTitle:@"Okay" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        UIApplication *app = [UIApplication sharedApplication];
        
        UIUserNotificationType types = UIUserNotificationTypeBadge |
        UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [app registerUserNotificationSettings:settings];
        [app registerForRemoteNotifications];
    }];
    [alert show];
    
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:NMPushNotificationsKey];
}


@end
