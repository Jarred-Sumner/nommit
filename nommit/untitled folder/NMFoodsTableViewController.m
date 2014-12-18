    //
//  NMFoodsTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodsTableViewController.h"
#import "NMFoodTableViewCell.h"
#import "NMPlaceDropdownView.h"
#import "NMMenuNavigationController.h"
#import "NMFoodCellHeaderView.h"
#import "NMFood.h"
#import <REFrostedViewController.h>
#import <SVProgressHUD.h>
#import "NMPlacesTableViewController.h"
#import "NMOrderFoodViewController.h"
#import "NMRateOrderTableViewController.h"
#import "NMNoFoodView.h"
#import "NMAppDelegate.h"
#import "KLCPopup.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

static BOOL didAutoPresentPlaces = NO;

static NSString *NMFoodCellIdentifier = @"FoodCellIdentifier";
static NSString *NMLocationCellIdentifier = @"LocationCellIdentifier";

@interface NMFoodsTableViewController ()

@property (nonatomic, strong) NMNoFoodView *noFoodView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NMPlaceDropdownView *headerView;

@end

@implementation NMFoodsTableViewController

- (id)init {
    self = [self initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
        [(NMMenuNavigationController*)self.navigationController setDisabledMenu:NO];
        
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initNavBar];
        [self setupDataSource];
        
        [self.tableView registerClass:[NMFoodTableViewCell class] forCellReuseIdentifier:NMFoodCellIdentifier];
        [self.tableView addParallaxWithImage:[UIImage imageNamed:@"HoursBanner"] andHeight:130];
        [self.tableView.parallaxView setAutoresizingMask:UIViewAutoresizingNone];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    _noFoodView = [[NMNoFoodView alloc] initWithFrame:CGRectInset(self.tableView.bounds, 0, NMPlaceDropdownTableViewCellHeight)];
    _noFoodView.hidden = YES;
    [self.tableView addSubview:_noFoodView];
}

- (id)initWithPlace:(NMPlace *)place {
    self = [self init];
    self.place = place;
    return self;
}

- (void)setPlace:(NMPlace *)place {
    _place = place;
    _fetchedResultsController = nil;
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    NMMenuNavigationController *navController = (NMMenuNavigationController *)self.navigationController;
    navController.frostedViewController.panGestureEnabled = YES;
    navController.navigationBar.translucent = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!_place) self.place = [NMPlace activePlace];
    
    _fetchedResultsController = nil;
    [self.fetchedResultsController performFetch:nil];
    
    if (_place) {
        [self refresh];
        [self handlePendingOrders];
    } else if (!didAutoPresentPlaces && [NMFood countOfActiveFoods] > 0) {
        [self locationButtonTouched];
        didAutoPresentPlaces = YES;
    } else {
        [self refreshFood];
    }
    

    // Register for push notifications
    [(NMAppDelegate*)[[UIApplication sharedApplication] delegate] registerForPushNotifications];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) return _fetchedResultsController;
        
    NSPredicate *foodPredicate;
    if (_place) {
        // The foods we show match the following:
        // - Are orderable
        // - Are orderable, but not to that place
        // - Stopped being sold (due to endDate being < now)
        // - Haven't been sold (startDate > now)
        // - Have sold out
        foodPredicate = [NSPredicate predicateWithFormat:@"ANY deliveryPlaces.place = %@ AND SUBQUERY(deliveryPlaces, $dp, $dp.stateID IN %@ AND $dp.place = %@).@count > 0 AND (endDate >= %@) AND (startDate <= %@) AND stateID = %@", _place, @[@(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateReady), @(NMDeliveryPlaceStatePending)], _place, [NSDate date], [NSDate date], @(NMFoodStateActive)];
    } else {
        foodPredicate = [NSPredicate predicateWithFormat:@"endDate >= %@", [[NSDate date] dateByAddingTimeInterval:-86400]];
    }
    
    _fetchedResultsController = [NMFood MR_fetchAllSortedBy:@"startDate" ascending:NO withPredicate:foodPredicate groupBy:nil delegate: self];
    return _fetchedResultsController;
}

- (void)setupDataSource {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)refresh {
    if (!_place && [NMFood countOfActiveFoods] > 0 && !didAutoPresentPlaces) {
        [self locationButtonTouched];
        [self.refreshControl endRefreshing];
        return;
    }

    [self.refreshControl beginRefreshing];
    if (_place) {
        [self refreshFoodForPlace:_place];
    } else {
        [self refreshFood];
    }
    
}

- (void)refreshFoodForPlace:(NMPlace*)place {
    __weak NMFoodsTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"places/%@", place.uid] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        if ([[response.result foodCount] integerValue] == 0) {
            this.place = nil;
            [NMPlace setActivePlace:nil];
            [self.tableView reloadData];
        }

        [this didRefresh];
    }];
}

- (void)refreshFood {
    __weak NMFoodsTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"foods"] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        [this didRefresh];
    }];
}

- (void)didRefresh {
    __block NMFoodsTableViewController *this = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [this.refreshControl endRefreshing];
        [this.fetchedResultsController performFetch:nil];
    });
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
            [self configureCell:(UITableViewCell*)[tableView cellForRowAtIndexPath:indexPath] forIndexPath:indexPath];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    NSUInteger count = [sectionInfo numberOfObjects];
    
    // Side effects!
    _noFoodView.hidden = count != 0;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 243;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return NMPlaceDropdownTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [[NMPlaceDropdownView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), NMPlaceDropdownTableViewCellHeight)];
    if (_place) {
        [_headerView.locationButton setTitle:[NSString stringWithFormat:@"Delivering to: %@", _place.name] forState:UIControlStateNormal];
    } else {
        [_headerView.locationButton setTitle:@"Pick a Delivery Location" forState:UIControlStateNormal];
    }

    [_headerView.locationButton addTarget:self action:@selector(locationButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    return _headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NMFood *food = (NMFood*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (food.orderable) {

        if (!_place) {
            [self locationButtonTouched];
            return;
        }

        NMOrderFoodViewController *orderFoodVC = [[NMOrderFoodViewController alloc] initWithFood:food place:_place];
        [self.navigationController pushViewController:orderFoodVC animated:YES];
    } else if (food.timingState == NMFoodTimingStatePending) {

    }
}

- (void)configureCell:(NMFoodTableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath {
    NMFood *food = [self.fetchedResultsController objectAtIndexPath:indexPath];

    __block NMFoodsTableViewController *this = self;
    [cell setFood:food timerEndedBlock:^(NSTimeInterval elapsed) {
        [this refresh];
    }];
    
    if (food.state != NMFoodStateActive) {
        [cell setState:NMFoodCellStateExpired];
    } else {
        if (food.quantityState == NMFoodQuantityStateActive) {
            if (food.timingState == NMFoodTimingStateActive) {
                [cell setState:NMFoodCellStateNormal];
            } else if (food.timingState == NMFoodTimingStateExpired) {
                [cell setState:NMFoodCellStateExpired];
            } else if (food.timingState == NMFoodTimingStatePending) {
                [cell setState:NMFoodCellStateFuture];
                [cell.notifyButton addTarget:self action:@selector(notifyUser:) forControlEvents:UIControlEventTouchUpInside];
            }
        } else {
            [cell setState:NMFoodCellStateSoldOut];
        }
    }

}

- (void)notifyUser:(id)sender {
    CGPoint point = [sender convertPoint:CGPointZero toView:self.tableView];
    __block NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    NMFood *food = [self.fetchedResultsController objectAtIndexPath:indexPath];
    __block NSNumber *foodID = food.uid;
    __block NMFoodTableViewCell *cell = (NMFoodTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    [SVProgressHUD showWithStatus:@"Saving..." maskType:SVProgressHUDMaskTypeBlack];
    
    __block NMFoodsTableViewController *this = self;
    NSString *path = [NSString stringWithFormat:@"users/%@", [NMUser currentUser].facebookUID];
    [[NMApi instance] PUT:path parameters:@{ @"push_notifications" : @"reset" } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NMFood *food = [NMFood MR_findFirstByAttribute:@"uid" withValue:foodID inContext:localContext];
            food.willNotifyUser = @YES;
        } completion:^(BOOL success, NSError *error) {
            [SVProgressHUD showSuccessWithStatus:@"Saved!"];
            [this configureCell:cell forIndexPath:indexPath];
        }];

        
    }];
}

#pragma mark - nav bar

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
            style:UIBarButtonItemStylePlain
            target:(NMMenuNavigationController *)self.navigationController
            action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    if (!self.navigationItem.leftBarButtonItem) self.navigationItem.leftBarButtonItem = lbb;
    self.title = @"Menu";

    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - location button
- (void)locationButtonTouched
{
    NMPlacesTableViewController *placesVC = [[NMPlacesTableViewController alloc] init];
    placesVC.foodsVC = self;
    
    NMMenuNavigationController *navController =
    [[NMMenuNavigationController alloc] initWithRootViewController:placesVC];
    navController.navigationBar.translucent = NO;
    [self presentViewController:navController animated:YES completion:^{
        self.place = [NMPlace activePlace];
    }];
}

#pragma mark - Handle Rating Orders

// Rate pending orders
- (void)handlePendingOrders {
    if ([[NMUser currentUser] hasOrdersPendingRating]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@ AND stateID = %@", [NMUser currentUser], @(NMOrderStateDelivered)];
        NMOrder *order = [NMOrder MR_findFirstWithPredicate:predicate];
        NMRateOrderTableViewController *rateVC = [[NMRateOrderTableViewController alloc] initWithOrder:order];
        [self presentViewController:rateVC animated:YES completion:NULL];
    }
}



@end
