//
//  NMFoodOrdersTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodDeliveryPlaceTableViewController.h"
#import "NMFoodDeliveryPlaceNavigatorView.h"
#import "NMOrderTableViewCell.h"
#import "NMMenuNavigationController.h"
#import "NMFoodDeliveryPlaceFooter.h"

static NSTimeInterval NMOrderFetchInterval = 5;

static NSString *NMOrderTableViewCellIdentifier = @"NMOrderTableViewCellIdentifier";

@interface NMFoodDeliveryPlaceTableViewController() <NMFoodDeliveryPlaceNavigatorDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMFoodDeliveryPlaceNavigatorView *placeNavigatorView;
@property (nonatomic, strong) NMFoodDeliveryPlaceFooter *footerView;

@property (nonatomic, strong) NSTimer *orderFetchTimer;


@end

@implementation NMFoodDeliveryPlaceTableViewController

- (void)loadView {
    [super loadView];
    [self initNavBar];
    self.view.backgroundColor = [NMColors lightGray];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    
    _footerView = [[NMFoodDeliveryPlaceFooter alloc] init];
    _footerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_footerView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView]|" options:(NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight) metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];

    
    
    [self.tableView registerClass:[NMOrderTableViewCell class] forCellReuseIdentifier:NMOrderTableViewCellIdentifier];
    [self setTableViewHeader];
}

- (void)setTableViewHeader {
    _placeNavigatorView = [[NMFoodDeliveryPlaceNavigatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), NMOrderLocationViewHeight)];
    _placeNavigatorView.nameLabel.text = self.place.name;
    _placeNavigatorView.deliveryPlaces = self.deliveryPlaces;
    _placeNavigatorView.delegate = self;
    self.tableView.tableHeaderView = _placeNavigatorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fetchedResultsController performFetch:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startFetchingOrders];
    [self updateRevenueText];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.fetchedResultsController.delegate = nil;
    _fetchedResultsController = nil;
    
    [_orderFetchTimer invalidate];
    _orderFetchTimer = nil;
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courier IN %@ AND place = %@ AND stateID = %@", [[NMUser currentUser] couriers], self.place, @(NMOrderStateActive)];
    _fetchedResultsController = [NMOrder MR_fetchAllSortedBy:@"placedAt" ascending:NO withPredicate:predicate groupBy:nil delegate: self inContext:[NSManagedObjectContext MR_defaultContext]];
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    NMOrderTableViewCell *cell = (NMOrderTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
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
            [self configureCell:cell atIndexPath:indexPath];
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
    [self updateRevenueText];
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMOrderTableViewCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NMOrderTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = order.user.name;
    cell.orderName.text = [NSString stringWithFormat:@"%@ - %@", order.quantity, order.food.title];
    cell.profileAvatar.profileID = order.user.facebookUID;
    
    [cell.callButton addTarget:self action:@selector(callUser:) forControlEvents:UIControlEventTouchUpInside];
    [cell.doneButton addTarget:self action:@selector(orderComplete:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Order-specific actions

- (void)callUser:(id)sender
{
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *phNo = order.user.phone;
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Phone call errored. Try Again." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (void)orderComplete:(id)sender
{
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *path = [NSString stringWithFormat:@"orders/%@", order.uid];
    
    __block NMFoodDeliveryPlaceTableViewController *this = self;
    [[NMApi instance] PUT:path parameters:@{ @"state_id" : @(NMOrderStateDelivered) } completion:^(OVCResponse *response, NSError *error) {
        if ([response.result class] == [NMErrorApiModel class]) [response.result handleError];
    }];
}

#pragma mark - Place-specific actions

- (NSArray*)places {
    if (!_places) {
        __block NSMutableSet *places = [[NSMutableSet alloc] init];
        [[self deliveryPlaces] enumerateObjectsUsingBlock:^(NMFoodDeliveryPlace *deliveryPlace, NSUInteger idx, BOOL *stop) {
            [places addObject:deliveryPlace.place];
        }];
        _places = [places allObjects];
    }
    return _places;
}

- (NMPlace*)place {
    return self.places[0];
}

- (NSArray*)deliveryPlaces {
    return [NMFoodDeliveryPlace placesForCourier:NMCourier.currentCourier];
}


#pragma mark - Navigation

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
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - Revenue Text

- (void)updateRevenueText {
    __block double revenue = 0;
    __block NMPlace *place = [self place];
    [self.place.foods enumerateObjectsUsingBlock:^(NMFood *food, NSUInteger idx, BOOL *stop) {
        NSPredicate *deliverPredicate = [NSPredicate predicateWithFormat:@"food = %@ AND stateID = %@ AND place = %@", food, @(NMOrderStateDelivered), place];
        NSNumber *deliverCount = @([NMOrder MR_countOfEntitiesWithPredicate:deliverPredicate]);
        revenue += deliverCount.doubleValue * food.price.doubleValue;
    }];
    self.footerView.revenueLabel.text = [NSString stringWithFormat:@"Total Delivered: $%@", @(revenue)];
}

#pragma mark - Fetch Orders

- (void)startFetchingOrders {
    _orderFetchTimer = [NSTimer scheduledTimerWithTimeInterval:NMOrderFetchInterval target:self selector:@selector(fetchOrders) userInfo:nil repeats:YES];
    [self fetchOrders];
}

- (void)fetchOrders {
    [[NMApi instance] GET:[NSString stringWithFormat:@"places/%@/orders", self.place.uid] parameters:nil completion:NULL];
}

#pragma mark - De-alloc

- (void)dealloc {
    [_orderFetchTimer invalidate];
    _orderFetchTimer = nil;
    _places = nil;
    _placeNavigatorView.delegate = nil;
    _placeNavigatorView = nil;
    _fetchedResultsController.delegate = nil;
    _fetchedResultsController = nil;
}



@end
