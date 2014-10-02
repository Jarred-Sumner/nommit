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
#import "NMFoodsTableViewController.h"
#import "NMMenuNavigationController.h"
#import "NMColors.h"

#import "NMDeliveryPlaceTableViewController.h"
#import "NMDeliveryPlacesTableViewController.h"
#import "NMAccountTableViewController.h"
#import "NMDeliveryTableViewController.h"

#import "NMLoginViewController.h"
#import "NMRateTableViewController.h"
#import "NMCourierSummaryTableViewController.h"
#import "THContactPickerViewController.h"
#import "NMInviteCodeViewController.h"

static NSInteger NMStaticSection = 0;
static NSInteger NMOrdersSection = 1;

@interface NMMenuViewController ()

@property (nonatomic, strong) FBProfilePictureView *pictureView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

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
        _pictureView = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        
        _pictureView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        _pictureView.layer.masksToBounds = YES;
        _pictureView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _pictureView.profileID = [NMSession userID];
        _pictureView.layer.shouldRasterize = YES;
        _pictureView.clipsToBounds = YES;
        
        CAShapeLayer *circle = [CAShapeLayer layer];
        // Make a circular shape
        
        CGRect pathRect = CGRectMake(0, 0, CGRectGetWidth(_pictureView.frame), CGRectGetHeight(_pictureView.frame));
        CGFloat pathRadius = MAX(CGRectGetWidth(_pictureView.frame), CGRectGetHeight(_pictureView.frame));
                                 
        UIBezierPath *circularPath=[UIBezierPath bezierPathWithRoundedRect:pathRect cornerRadius:pathRadius];
        
        circle.path = circularPath.CGPath;
        _pictureView.layer.mask = circle;
        
        // Configure the apperence of the circle
        circle.fillColor = [UIColor blackColor].CGColor;
        circle.strokeColor = [UIColor blackColor].CGColor;
        circle.lineWidth = 0;
        _pictureView.layer.mask = circle;
        
        UILabel *usernameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        usernameLabel.text = [[NMUser currentUser] name];
        usernameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        usernameLabel.backgroundColor = [UIColor clearColor];
        usernameLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [usernameLabel sizeToFit];
        usernameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

        [view addSubview:_pictureView];
        [view addSubview:usernameLabel];
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
    if (sectionIndex == 0) return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [NMColors mainColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text = @"Active Orders";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0) return 0;
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if ([[NMUser currentUser] isCourierValue]) {
            if (indexPath.row == 0) {
                [self showMenu];
            } else if (indexPath.row == 1) {
                [self showOrders];
            } else if (indexPath.row == 2) {
                [self showAccount];
            } else if (indexPath.row == 3) {
                [self showInvite];
            }
        } else {
            if (indexPath.row == 0) {
                [self showMenu];
            } else if (indexPath.row == 1) {
                [self showAccount];
            } else if (indexPath.row == 2) {
                [self showInvite];
            }
        }

    } else if (indexPath.section == 1) {
        // Correct the indexPath to account for only one section in fetched results controller
        indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        
        NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        NMDeliveryTableViewController *deliveryVC = [[NMDeliveryTableViewController alloc] initWithOrder:order];
        
//        NMCourierSummaryTableViewController *deliveryVC = [[NMCourierSummaryTableViewController alloc] initWithShift:nil];
        
//        NMRateTableViewController *deliveryVC = [[NMRateTableViewController alloc] initWithOrder:order];
//        NMMenuNavigationController *navController =
//        [[NMMenuNavigationController alloc] initWithRootViewController:deliveryVC];
//        [self presentViewController:navController animated:YES completion:nil];
        
        [self navigateTo:deliveryVC];
    }
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    
    NSPredicate *ordersPredicate = [NSPredicate predicateWithFormat:@"stateID = %@ AND user = %@", @(NMOrderStateActive), NMUser.currentUser];
    
    _fetchedResultsController = [NMOrder MR_fetchAllSortedBy:@"placedAt" ascending:NO withPredicate:ordersPredicate groupBy:nil delegate: self];
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    // Section is offset by 1 for the fetchedResultsController
    indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
    newIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:1];
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureOrderCell:(UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
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
    if (sectionIndex == 0) {
        if ([NMUser currentUser].isCourierValue) {
            return 4;
        } else {
            return 3;
        }
    } else if (sectionIndex == 1) {
        id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
        return [sectionInfo numberOfObjects];
    } else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles;
        if ([[NMUser currentUser] isCourierValue]) {
            titles = @[@"Menu", @"Deliver", @"Account", @"Invite"];
        } else {
            titles = @[@"Menu", @"Account", @"Invite"];
        }
        cell.textLabel.text = titles[indexPath.row];
    } else {
        [self configureOrderCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

- (void)configureOrderCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath *)indexPath {
    indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = order.food.title;
}

#pragma mark - Navigate to Controllers

- (void)showMenu {
    NMFoodsTableViewController *menuVC = [[NMFoodsTableViewController alloc] init];
    [self navigateTo:menuVC];
}

- (void)showOrders {
    NMShift *currentShift = [[NMCourier currentCourier] currentShift];
    
    NMDeliveryPlacesTableViewController *pickPlacesTVC = [[NMDeliveryPlacesTableViewController alloc] initWithShift:currentShift];
    
    NMDeliveryPlaceTableViewController *ordersVC = [[NMDeliveryPlaceTableViewController alloc] initWithShift:currentShift];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:pickPlacesTVC];
    if (currentShift) {
        [navVC pushViewController:ordersVC animated:NO];
    }
    [self presentViewController:navVC animated:YES completion:nil];
}

- (void)showAccount {
    NMAccountTableViewController *accountTableVC = [[NMAccountTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self navigateTo:accountTableVC];
}

- (void)showInvite {
//    THContactPickerViewController *inviteVC = [[THContactPickerViewController alloc] initWithNibName:nil bundle:nil];
    NMInviteCodeViewController *inviteVC = [[NMInviteCodeViewController alloc] init];
    [self navigateTo:inviteVC];
}

- (void)navigateTo:(UIViewController*)viewController {
    NMMenuNavigationController *navigationController = [[NMMenuNavigationController alloc] initWithRootViewController:viewController];
    navigationController.navigationBar.translucent = NO;
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

@end
