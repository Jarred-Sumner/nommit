//
//  NMMenuNavigationController.m
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMNavigationController.h"
#import "NMRateOrderTableViewController.h"

@interface NMNavigationController ()

@property (strong, readwrite, nonatomic) NMNavigationController *menuViewController;

@end

@implementation NMNavigationController

- (void)loadView {
    [super loadView];
    self.navigationBar.translucent = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)]];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
}

- (void)showMenu
{
    // Dismiss keyboard (optional)
    //
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    // Present the view controller
    //
    [self.frostedViewController presentMenuViewController];
}

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
    if (!_disabledMenu) {
        // Dismiss keyboard (optional)
        //
        [self.view endEditing:YES];
        [self.frostedViewController.view endEditing:YES];
        
        // Present the view controller
        //
        [self.frostedViewController panGestureRecognized:sender];
    }
}

@end