//
//  NMAppDelegate.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAppDelegate.h"
#import "NMTabsController.h"
#import "NMCollectionViewSmallLayout.h"
#import "HATransitionController.h"
#import "NMSmallCollectionViewController.h"

@interface NMAppDelegate () <UINavigationControllerDelegate, HATransitionControllerDelegate>

@property (nonatomic) HATransitionController *transitionController;

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    
//    NMTabsController *tc = [[NMTabsController alloc] init];
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tc];
//    self.navigationController = navigationController;
//    self.window.rootViewController = navigationController;
//    [self.window makeKeyAndVisible];
    
    NMCollectionViewSmallLayout *smallLayout = [[NMCollectionViewSmallLayout alloc] init];
    NMSmallCollectionViewController *collectionViewController = [[NMSmallCollectionViewController alloc] initWithCollectionViewLayout:smallLayout];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:collectionViewController];
    self.navigationController = navigationController;
    self.navigationController.delegate = self;
    
    self.transitionController = [[HATransitionController alloc] initWithCollectionView:collectionViewController.collectionView];
    self.transitionController.delegate = self;
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)interactionBeganAtPoint:(CGPoint)point
{
    // Very basic communication between the transition controller and the top view controller
    // It would be easy to add more control, support pop, push or no-op
    NMSmallCollectionViewController *presentingVC = (NMSmallCollectionViewController *)[self.navigationController topViewController];
    NMSmallCollectionViewController *presentedVC = (NMSmallCollectionViewController *)[presentingVC nextViewControllerAtPoint:point];
    if (presentedVC!=nil)
    {
        [self.navigationController pushViewController:presentedVC animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    if (animationController==self.transitionController) {
        return self.transitionController;
    }
    return nil;
}


- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (![fromVC isKindOfClass:[UICollectionViewController class]] || ![toVC isKindOfClass:[UICollectionViewController class]])
    {
        return nil;
    }
    if (!self.transitionController.hasActiveInteraction)
    {
        return nil;
    }
    
    self.transitionController.navigationOperation = operation;
    return self.transitionController;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
