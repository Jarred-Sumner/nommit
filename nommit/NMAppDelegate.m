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

@interface NMAppDelegate ()

@end

@implementation NMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MagicalRecord setupAutoMigratingCoreDataStack];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[NMFoodsViewController alloc] init]];
    
//    NMApi *api = [[NMApi alloc] initWithBaseURL:[NSURL URLWithString:@"http://nommit-api.herokuapp.com"] managedObjectContext:[NSManagedObjectContext MR_defaultContext] sessionConfiguration:nil];
//    [api GET:@"orders" parameters:@{@"access_token": @"CAACEdEose0cBAKsEmpmL1ZCC2ojnVZAce3bSUbRjJJ8S1xwMNBUouv10jl5X2V2jv3r5MGqwZCKyMhTaZCJgNrBVhI46o4Y2BUkZCWVTGrKnlfyyMmEFDLOtfj0k4gHhoUlwtoIJFRxc9NOcgME6mm0gVAsGVUCZBMjRGcsFJKuaQuB3v0jLVaptadeHSwOVN3QrvZACp18Bhu49tZAfwnXMZA7VOQwF9yZA8ZD"} completion:^(OVCResponse *response, NSError *error) {
//        NSLog(@"Error: %@", error);
//        NSLog(@"Order Count: %d", [NMOrder MR_countOfEntities]);
//        NSLog(@"Food Count: %d", [NMFood MR_countOfEntities]);
//        NSLog(@"Address Count: %d", [NMAddress MR_countOfEntities]);
//        NSLog(@"User Count: %d", [NMUser MR_countOfEntities]);
//    }];

    
    // create content and menu controllers
    NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:[[NMLoginViewController alloc] init]];
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

@end
