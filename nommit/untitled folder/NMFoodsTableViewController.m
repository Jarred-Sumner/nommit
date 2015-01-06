    //
//  NMFoodsTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMFoodsTableViewController.h"
#import "NMFoodTableViewCell.h"
#import "NMNavigationController.h"
#import "NMFoodCellHeaderView.h"
#import "NMFood.h"
#import <REFrostedViewController.h>
#import <SVProgressHUD.h>
#import "NMPlacesTableViewController.h"
#import "NMOrderFoodViewController.h"
#import "NMRateOrderTableViewController.h"
#import "NMAppDelegate.h"
#import "KLCPopup.h"
#import "NMHoursBannerView.h"
#import "NMBecomeASellerFooterView.h"
#import "NMBecomeASellerTableViewController.h"

#import "NMPlaceTitleView.h"
#import "NMNoFoodView.h"


static BOOL didAutoPresentPlaces = NO;

static NSString *NMFoodCellIdentifier = @"FoodCellIdentifier";
static NSString *NMLocationCellIdentifier = @"LocationCellIdentifier";

const NSInteger NMFooterSection = 1;

typedef NS_ENUM(NSInteger, NMFoodsTableViewControllerState) {
    NMFoodsTableViewControllerStateNoFoods = 0,
    NMFoodsTableViewControllerStateFoods
};

@interface NMFoodsTableViewController ()

@property (nonatomic, strong) NMNoFoodView *noFoodView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic) NMFoodsTableViewControllerState state;

@property (nonatomic, strong) NMBecomeASellerFooterView *footerView;


@end

@implementation NMFoodsTableViewController

#pragma mark - Place

- (id)initWithPlace:(NMPlace *)place {
    self = [self init];
    self.place = place;
    return self;
}

- (void)setPlace:(NMPlace *)place {
    _place = place;
    _fetchedResultsController = nil;
    [self.fetchedResultsController performFetch:nil];
    
    self.navigationItem.titleView = [[NMPlaceTitleView alloc] initWithFrame:CGRectMake(0, -4, 200, 44) title:@"" target:self selector:@selector(showPlaces)];
    if (place) {
        [(NMPlaceTitleView*)self.navigationItem.titleView setTitle:place.name];
    } else {
        [(NMPlaceTitleView*)self.navigationItem.titleView setTitle:@"Pick Place"];
    }
}

- (void)showPlaces
{
    NMPlacesTableViewController *placesVC = [[NMPlacesTableViewController alloc] init];
    placesVC.foodsVC = self;
    
    NMNavigationController *navController =
    [[NMNavigationController alloc] initWithRootViewController:placesVC];
    navController.navigationBar.translucent = NO;
    [self presentViewController:navController animated:YES completion:^{
        self.place = [NMPlace activePlace];
    }];
}

#pragma mark - Setup Views

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = UIColorFromRGB(0xF3F1F1);
    
    [(NMNavigationController*)self.navigationController setDisabledMenu:NO];
    [self initNavBar];
    [self loadTableView];
    [self loadNoFoodView];
    [self loadFooterView];
}

- (void)loadTableView {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if ([self.tableView respondsToSelector:@selector(separatorInset)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self.tableView registerClass:[NMFoodTableViewCell class] forCellReuseIdentifier:NMFoodCellIdentifier];
    
    [self loadTableViewHeader];
    
    UITableViewController *tvc = [[UITableViewController alloc] initWithStyle:self.tableView.style];
    tvc.tableView = self.tableView;
    tvc.refreshControl = self.refreshControl;

    [self addChildViewController:tvc];
    [self.view addSubview:self.tableView];
}

- (void)loadTableViewHeader {
    NMHoursBannerView *hoursView = [[NMHoursBannerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 25)];
    self.tableView.tableHeaderView = hoursView;

    [self configureTableViewHeader];
}

- (void)loadFooterView {
    [_footerView removeFromSuperview];
    _footerView = nil;
    _footerView = [[NMBecomeASellerFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 222)];
    _footerView.footerText.text = @"Turn food students love into cash. \n Make up to $150/hour selling food on Nommit.";
    [_footerView.footerButton addTarget:self action:@selector(openSellerPage) forControlEvents:UIControlEventTouchUpInside];
}


- (void)loadNoFoodView {
    self.noFoodView = [[NMNoFoodView alloc] init];
    self.noFoodView.translatesAutoresizingMaskIntoConstraints = NO;
    self.noFoodView.opaque = YES;
    
    [self.view insertSubview:_noFoodView belowSubview:self.tableView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_noFoodView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_noFoodView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-24-[_noFoodView(260)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_noFoodView)]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    
    NMNavigationController *navController = (NMNavigationController *)self.navigationController;
    navController.frostedViewController.panGestureEnabled = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!_place) self.place = [NMPlace activePlace];
    
    if (_place) {
        [self refresh];
        [self handlePendingOrders];
    } else if (!didAutoPresentPlaces && [NMFood countOfActiveFoods] > 0) {
        [self showPlaces];
        didAutoPresentPlaces = YES;
    } else {
        [self refreshFood];
    }

    // Register for push notifications
    [(NMAppDelegate*)[[UIApplication sharedApplication] delegate] registerForPushNotifications];
    self.state = [self.fetchedResultsController.sections[0] numberOfObjects] > 0 ? NMFoodsTableViewControllerStateFoods : NMFoodsTableViewControllerStateNoFoods;
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
    
    _fetchedResultsController = [NMFood MR_fetchAllSortedBy:@"featured" ascending:NO withPredicate:foodPredicate groupBy:nil delegate: self];
    return _fetchedResultsController;
}

- (void)refresh {
    if (!_place && [NMFood countOfActiveFoods] > 0 && !didAutoPresentPlaces) {
        [self showPlaces];
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
            [self.fetchedResultsController performFetch:nil];
        }

        [this didRefresh];
    }];
}

- (void)refreshFood {
    __weak NMFoodsTableViewController *this = self;
    
    [[NMApi instance] GET:[NSString stringWithFormat:@"foods"] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        [this didRefresh];
        [self.fetchedResultsController performFetch:nil];
    }];
}

- (void)didRefresh {
    __block NMFoodsTableViewController *this = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [this.refreshControl endRefreshing];
        [self.fetchedResultsController performFetch:nil];
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
        default:
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
    [self configureTableViewHeader];
    self.state = [controller.sections[0] numberOfObjects] > 0 ? NMFoodsTableViewControllerStateFoods : NMFoodsTableViewControllerStateNoFoods;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 198.5;
}

#pragma mark - Spacing for Footer View

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectMake(0,0,1,44.0)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    NMFood *food = (NMFood*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (food.orderable) {

        if (!_place) {
            [self showPlaces];
            return;
        }

        NMOrderFoodViewController *orderFoodVC = [[NMOrderFoodViewController alloc] initWithFood:food place:_place];
        [self.navigationController pushViewController:orderFoodVC animated:YES];
    } else if (food.timingState == NMFoodTimingStatePending) {

    }
}

- (void)configureCell:(UITableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath {
    NMFoodTableViewCell *foodCell = (NMFoodTableViewCell*)cell;
    NMFood *food = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [foodCell setFood:food];
}

- (void)configureTableViewHeader {
    NMHoursBannerView *hoursView = self.tableView.tableHeaderView;
    
    NMSchool *school = [NMSchool currentSchool];
    if (school.messageState == NMSchoolMessageStateHours) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateStyle = NSDateFormatterNoStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;
        
        hoursView.hoursLabel.text = [NSString stringWithFormat:@"Weekdays %@ - %@", [formatter stringFromDate:school.fromHours], [formatter stringFromDate:school.toHours]];
    } else if (school.messageState == NMSchoolMessageStateMOTD) {
        hoursView.hoursLabel.text = school.motd;
    } else if (school.messageState == NMSchoolMessageStateSpecialEvents) {
        hoursView.hoursLabel.text = @"Only for Special Events";
    }
}

#pragma mark - nav bar

- (void)initNavBar
{
    [self.navigationController.navigationBar setTranslucent:NO];
    
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
            style:UIBarButtonItemStylePlain
            target:(NMNavigationController *)self.navigationController
            action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    lbb.imageInsets = UIEdgeInsetsMake(1, 0, 0, 0);
    if (!self.navigationItem.leftBarButtonItem) self.navigationItem.leftBarButtonItem = lbb;
    self.navigationController.navigationBarHidden = NO;
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:UIColorFromRGB(0x9C9C9C) forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)] forKey:UITextAttributeTextShadowOffset];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
}

#pragma mark - Misc

// Rate pending orders
- (void)handlePendingOrders {
    if ([[NMUser currentUser] hasOrdersPendingRating]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@ AND stateID = %@", [NMUser currentUser], @(NMOrderStateDelivered)];
        NMOrder *order = [NMOrder MR_findFirstWithPredicate:predicate];
        NMRateOrderTableViewController *rateVC = [[NMRateOrderTableViewController alloc] initWithOrder:order];
        [self presentViewController:rateVC animated:YES completion:NULL];
    }
}

- (BOOL)hasFoods {
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    return [sectionInfo numberOfObjects] > 0;
}

- (void)openSellerPage {
    NMBecomeASellerTableViewController *seller = [[NMBecomeASellerTableViewController alloc] initModalWithStyle:UITableViewStylePlain];
    [self.navigationController presentViewController:[[NMNavigationController alloc] initWithRootViewController:seller] animated:YES completion:NULL];
}

#pragma mark - State

- (void)setState:(NMFoodsTableViewControllerState)state {
    if (state == NMFoodsTableViewControllerStateFoods) {
        _noFoodView.hidden = YES;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 66, 0);
        [self loadFooterView];
        self.tableView.tableFooterView = _footerView;
        _footerView.translatesAutoresizingMaskIntoConstraints = YES;
    } else {
        _noFoodView.hidden = NO;
        _noFoodView.state = [[NMSchool currentSchool] isClosed] ? NMNoFoodViewStateClosed : NMNoFoodViewStateUnknown;
        
        [self loadFooterView];
        _footerView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_footerView];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView(222)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerView)]];

    }
}


@end
