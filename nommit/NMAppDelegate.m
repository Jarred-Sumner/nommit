//
//  NMAppDelegate.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)


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
#import "NMSchoolsViewController.h"
#import <Crashlytics/Crashlytics.h>
#import "KLCPopup.h"
#import "NMNotificationPopupView.h"
#import "NMColors.h"



@interface NMAppDelegate ()

@property (nonatomic, strong) NMMenuNavigationController *navigationController;
@property (nonatomic, strong) KLCPopup *popup;

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [FBLoginView class];
    [Crashlytics startWithAPIKey:@"31fe8f31e5f07653f483f7db9bf622029dd41d84"];
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    [MagicalRecord setupAutoMigratingCoreDataStack];
    [self resetUI];
    
    [self.window makeKeyAndVisible];
    
    [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x42B7BB)];

    if ([NMSession isUserLoggedIn]) {
        [self checkForActiveOrders];
        
        // Always send off the device token on app load in case they changed whether or not push notifications is enabled
        if (self.isPushEnabled) {
            [self requestPushNotificationAccess];
        }
        
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
            
            __block NMMenuNavigationController *navVC = _navigationController;
            return [[NMSchoolsViewController alloc] initWithCompletionBlock:^{
                NMActivateAccountTableViewController *accountVC = [[NMActivateAccountTableViewController alloc] init];
                [navVC pushViewController:accountVC animated:YES];
            }];
            
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

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
    _navigationController = [[NMMenuNavigationController alloc] init];
    [_navigationController pushViewController:self.rootViewController animated:NO];

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
    NSUInteger rntypes;
    if (!SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        rntypes = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
    } else{
        rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    }
    
    if (rntypes > 0) {
    
        [[Mixpanel sharedInstance] track:@"Registered for Push Notifications"];
        NSString *token = [devToken base64EncodedStringWithOptions:0];
        NSLog(@"Push Notifications with Token: %@", token);

        [[NMApi instance] POST:@"devices" parameters:@{ @"token" : token }  completion:NULL];
        [[NSNotificationCenter defaultCenter] postNotificationName:NMDidRegisterForPushNotificationsKey object:nil];
    } else {
        [self application:app didFailToRegisterForRemoteNotificationsWithError:nil];
    }
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
    [[Mixpanel sharedInstance] track:@"Failed to Register for Push Notifications" properties:@{ @"error" : [NSString stringWithFormat:@"%@", err] }];
    [[NSNotificationCenter defaultCenter] postNotificationName:NMDidFailToRegisterForPushNotificationsKey object:nil];
}

- (void)registerForPushNotifications {
    if ([NMSession hasRequestedPush]) return;
    
    [[Mixpanel sharedInstance] track:@"Presented Push Notifications Request"];
    NSString *name = [[NMUser currentUser] name];
    
    NMNotificationPopupView *notificationPopupView = [[NMNotificationPopupView alloc] initWithFrame:CGRectMake(0, 0, 268.5, 382.5)];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@, we want you to know when Nommit has food. We'd really like it if you enabled push notifications, but you don't have to.", name]];;
    
    [notificationPopupView.contentView.messageLabel setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *text) {
        
        NSRange nameRange = [[text string] rangeOfString:name];
        NSRange knowWhen = [[text string] rangeOfString:@"know when Nommit has food"];
        NSRange dontHaveTo = [[text string] rangeOfString:@"you don't have to"];
        
        UIFont *uiFont = [UIFont fontWithName:@"Avenir-Medium" size:12];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
        if (font) {
            [text addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:nameRange];
            [text addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:knowWhen];
            [text addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:dontHaveTo];
        }
        return text;
    }];
 

    [notificationPopupView.contentView.notifyButton addTarget:self action:@selector(didTapNotifyButton) forControlEvents:UIControlEventTouchUpInside];

    _popup = [KLCPopup popupWithContentView:notificationPopupView showType:KLCPopupShowTypeGrowIn dismissType:KLCPopupDismissTypeFadeOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:NO dismissOnContentTouch:NO];
    [_popup show];
    
    [notificationPopupView.closeButton addTarget:self action:@selector(hideNotificationPopup) forControlEvents:UIControlEventTouchUpInside];
    
    [NMSession setRequestedPush:YES];
}

- (void)hideNotificationPopup {
    [[Mixpanel sharedInstance] track:@"Declined Push Notification Registration"];
    [_popup dismissPresentingPopup];
}

- (void)didTapNotifyButton {
    [_popup dismissPresentingPopup];
    [[Mixpanel sharedInstance] track:@"Requested Push Notification Access"];
    [self requestPushNotificationAccess];
}

- (void)requestPushNotificationAccess {
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

- (BOOL)isPushEnabled {
    BOOL enabled = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(isRegisteredForRemoteNotifications)]) {
        enabled =  [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
    }
#else
    UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if (types & UIRemoteNotificationTypeAlert) {
        enabled = true;
    }
#endif
    return enabled;
}


@end
