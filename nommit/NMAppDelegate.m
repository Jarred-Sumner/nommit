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
#import "KLCPopup.h"
#import "NMNotificationPopupView.h"
#import "NMColors.h"

static NSString *NMPushNotificationsKey = @"NMPushNotificationsKey";

@interface NMAppDelegate ()

@property (nonatomic, strong) NMMenuNavigationController *navigationController;
@property (nonatomic, strong) KLCPopup *popup;

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
    [[Mixpanel sharedInstance] track:@"Opened App"];
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
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:NMPushNotificationsKey] boolValue]) return;
    
    NSString *currentUserName = [NMUser currentUser].name;
    
    NMNotificationPopupView *notificationPopupView = [[NMNotificationPopupView alloc] initWithFrame:CGRectMake(0, 0, 268.5, 382.5)];
    notificationPopupView.contentView.messageLabel.text = [NSString stringWithFormat:@"Hi %@, we’d love to keep you in the loop of when food is available. In order to do so, you need to enable push notifications!", currentUserName ];
    [notificationPopupView.contentView.notifyButton addTarget:self action:@selector(showNotificationRegistration) forControlEvents:UIControlEventTouchUpInside];

    _popup = [KLCPopup popupWithContentView:notificationPopupView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
    [_popup show];
    
    [notificationPopupView.closeButton addTarget:_popup action:@selector(dismissPresentingPopup) forControlEvents:UIControlEventTouchUpInside];
    [alert show];
    
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:NMPushNotificationsKey];
}

- (void)showNotificationRegistration {
    [_popup dismissPresentingPopup];
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
            UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
            [[UIApplication sharedApplication] registerForRemoteNotifications];
        } else {
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        }
    #else
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    #endif
}


@end
