//
//  NMMenuViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/2/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMMenuViewController.h"
#import <REFrostedViewController.h>
#import <REFrostedContainerViewController.h>
//#import <UIViewController+REFrostedViewController.h>
#import "NMFoodsTableViewController.h"
#import "NMMenuNavigationController.h"
#import "NMPaymentsViewController.h"
#import "NMCreateCampaignViewController.h"
#import "NMLoginViewController.h"
#import "NMColors.h"

@interface NMMenuViewController ()

@end

@implementation NMMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"AvatarLucy"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        CAShapeLayer *circle = [CAShapeLayer layer];
        // Make a circular shape
        UIBezierPath *circularPath=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height) cornerRadius:MAX(imageView.frame.size.width, imageView.frame.size.height)];
        
        circle.path = circularPath.CGPath;
        imageView.layer.mask = circle;
        
        // Configure the apperence of the circle
        circle.fillColor = [UIColor blackColor].CGColor;
        circle.strokeColor = [UIColor blackColor].CGColor;
        circle.lineWidth = 0;
        imageView.layer.mask = circle;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text = @"Lucy Guo";
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [NMColors mainColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Food Ordered";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        NMFoodsTableViewController *homeViewController = [[NMFoodsTableViewController alloc] init];
        NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:homeViewController];
        self.frostedViewController.contentViewController = navigationController;
        navigationController.navigationBar.translucent = NO;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        NMPaymentsViewController *paymentsVC = [[NMPaymentsViewController alloc] init];
        NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:paymentsVC];
        self.frostedViewController.contentViewController = navigationController;
        navigationController.navigationBar.translucent = NO;
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        [NMSession setSessionID:nil];
        [NMSession setUserID:nil];
        
        NMLoginViewController *loginVC = [[NMLoginViewController alloc] init];
        NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:loginVC];
        self.frostedViewController.contentViewController = navigationController;
        navigationController.navigationBar.translucent = NO;
    } else {
        NMFoodsTableViewController *secondViewController = [[NMFoodsTableViewController alloc] init];
        NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:secondViewController];
        self.frostedViewController.contentViewController = navigationController;
        navigationController.navigationBar.translucent = NO;
    }
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Payments", @"Logout"];
        cell.textLabel.text = titles[indexPath.row];
    } else {
        NSArray *titles = @[@"Pepperoni Pizza", @"Dinosaur Nuggets", @"Pasta"];
        cell.textLabel.text = titles[indexPath.row];
    }
    
    return cell;
}

@end
