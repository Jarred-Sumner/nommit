//
//  NMFoodsTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodsTableViewController.h"
#import "NMFoodTableViewCell.h"
#import "NMLocationDropdownTableViewCell.h"
#import "NMMenuNavigationController.h"
#import "NMFoodCellHeaderView.h"
#import "NMFood.h"
#import <REFrostedViewController.h>
#import <SVProgressHUD.h>
#import "NMLocationContainerViewController.h"


static NSString *NMFoodCellIdentifier = @"FoodCellIdentifier";
static NSString *NMLocationCellIdentifier = @"LocationCellIdentifier";

@interface NMFoodsTableViewController ()<NMLocationContainerViewControllerDelegate>

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NMLocationDropdownTableViewCell *headerView;

@end

@implementation NMFoodsTableViewController

- (id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self initNavBar];
        [self setupDataSource];
        
        [self.tableView registerClass:[NMFoodTableViewCell class] forCellReuseIdentifier:NMFoodCellIdentifier];
    }
    return self;
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
    [self.fetchedResultsController performFetch:nil];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    
    NSPredicate *foodPredicate;
    if (_place) {
        foodPredicate = [NSPredicate predicateWithFormat:@"stateID = %@ AND places CONTAINS %@", @(NMFoodStateActive), _place];
    } else {
        // Predicate that never returns anything ever, for empty data source.
        foodPredicate = [NSPredicate predicateWithFormat:@"uid = %@", @(-1)];
    }
    
    _fetchedResultsController = [NMFood MR_fetchAllSortedBy:@"endDate" ascending:NO withPredicate:foodPredicate groupBy:nil delegate: self];
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
    return [sectionInfo numberOfObjects];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 243;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return NMLocationDropdownTableViewCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [[NMLocationDropdownTableViewCell alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), NMLocationDropdownTableViewCellHeight)];
    [_headerView.locationButton addTarget:self action:@selector(locationButtonTouched) forControlEvents:UIControlEventTouchUpInside];
    return _headerView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMFoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NMFoodTableViewCell*)cell forIndexPath:(NSIndexPath*)indexPath {
    cell.food = [self.fetchedResultsController objectAtIndexPath:indexPath];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)setupDataSource {
    if (!_place) _place = [NMPlace activePlace];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPlaces) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self refreshPlaces];
}

- (void)refreshPlaces {
    __weak NMFoodsTableViewController *this = self;
    [self.refreshControl beginRefreshing];
    
    [[NMApi instance] GET:@"places" parameters:nil completion:^(OVCResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error Updating: %@", error);
        } else {
            [NMPlaceApiModel placesForModels:response.result];
            this.place = [NMPlace activePlace];
            NSLog(@"Place: %@", this.place);
        }
        [this.refreshControl endRefreshing];
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
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
}

#pragma mark - location button
- (void)locationButtonTouched
{
    NMLocationContainerViewController *locationView = [[NMLocationContainerViewController alloc] init];
    locationView.delegate = self;
    NMMenuNavigationController *navController =
    [[NMMenuNavigationController alloc] initWithRootViewController:locationView];
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - NMLocationContainerViewControllerDelegate methods
- (void)setSelectedAddress:(NSString *)address
{
    // _headerView.locationButton
    NSString *titleString = [NSString stringWithFormat:@"Delivering to: %@", address];
    [_headerView.locationButton setTitle:titleString forState:UIControlStateNormal];
}

@end
