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
    self = [super init];
    if (self) {
        
        [(NMMenuNavigationController*)self.navigationController setDisabledMenu:NO];
        
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initNavBar];
        [self setupDataSource];
        
        [self.tableView registerClass:[NMFoodTableViewCell class] forCellReuseIdentifier:NMFoodCellIdentifier];
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
    if (place) {
        _place = place;
        _fetchedResultsController = nil;
        [self.tableView reloadData];
        [self.fetchedResultsController performFetch:nil];
    }

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    NMMenuNavigationController *navController = (NMMenuNavigationController *)self.navigationController;
    navController.frostedViewController.panGestureEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!_place) self.place = [NMPlace activePlace];
    if (_place) {
        [self refreshPlace];
        [self handlePendingOrders];
    } else if (!didAutoPresentPlaces) {
        [self locationButtonTouched];
        didAutoPresentPlaces = YES;
    }
    
    // Register for push notifications
    [(NMAppDelegate*)[[UIApplication sharedApplication] delegate] registerForPushNotifications];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
        
    NSPredicate *foodPredicate;
    if (_place) {
        NSDate *oneDayAgo = [NSDate dateWithTimeIntervalSinceNow:-(60 * 60 * 24)];
        NSDate *oneDayFromNow = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24];
        
        // The foods we show match the following:
        // - Are orderable
        // - Are orderable, but not to that place
        // - Stopped being sold (due to endDate being < now)
        // - Haven't been sold
        // - Have sold out
        foodPredicate = [NSPredicate predicateWithFormat:@"ANY deliveryPlaces.place = %@ AND SUBQUERY(deliveryPlaces, $dp, $dp.stateID IN %@ AND $dp.place = %@).@count > 0 AND (startDate <= %@) AND (endDate >= %@)", _place, @[@(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateReady), @(NMDeliveryPlaceStateEnded), @(NMDeliveryPlaceStatePending)], _place, oneDayFromNow, oneDayAgo];
    } else {
        // Predicate that never returns anything ever, for empty data source.
        foodPredicate = [NSPredicate predicateWithFormat:@"uid = %@", @(-1)];
    }
    
    _fetchedResultsController = [NMFood MR_fetchAllSortedBy:@"title" ascending:YES withPredicate:foodPredicate groupBy:nil delegate: self];
    return _fetchedResultsController;
}

- (void)setupDataSource {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPlace) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)refreshPlace {
    if (!_place) {
        [self locationButtonTouched];
        [self.refreshControl endRefreshing];
        return;
    }
    
    __weak NMFoodsTableViewController *this = self;
    [self.refreshControl beginRefreshing];
    
    [[NMApi instance] GET:[NSString stringWithFormat:@"places/%@", _place.uid] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [this.refreshControl endRefreshing];
            [this.fetchedResultsController performFetch:nil];
        });
    }];
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
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:count];

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
    NMOrderFoodViewController *orderFoodVC = [[NMOrderFoodViewController alloc] initWithFood:food place:_place];
    [self.navigationController pushViewController:orderFoodVC animated:YES];
}

- (void)configureCell:(NMFoodTableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath {
    NMFood *food = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NMDeliveryPlace *dp = [NMDeliveryPlace deliveryPlaceForFood:food place:_place];
    [cell setFood:food arrivalTime:dp.arrivesAt];
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
