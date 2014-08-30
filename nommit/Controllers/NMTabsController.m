//
//  NMTabsController.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMTabsController.h"
#import "NMSalesViewController.h"
#import "NMOrdersViewController.h"
#import "NMColors.h"

@interface NMTabsController ()

@end

@implementation NMTabsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.delegate = (id<UITabBarControllerDelegate>)self;
        [self setupTabBars];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabBars
{
    NMSalesViewController *svc = [[NMSalesViewController alloc]initWithNibName:nil bundle:nil];
    svc.title = @"Flash sales";
    svc.tabBarItem.image = [UIImage imageNamed:@"hometabsmall.png"];
    
    NMOrdersViewController *ovc = [[NMOrdersViewController alloc] initWithNibName:nil bundle:nil];
    ovc.title = @"Orders Placed";
    ovc.tabBarItem.image = [UIImage imageNamed:@"searchtabsmall.png"];
    
    
    self.viewControllers=[NSArray arrayWithObjects:[[UINavigationController alloc] initWithRootViewController:svc], [[UINavigationController alloc] initWithRootViewController:ovc], nil];
}


@end
