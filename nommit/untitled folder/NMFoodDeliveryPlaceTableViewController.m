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
@property (nonatomic, strong) NMFoodDeliveryPlace *deliveryPlace;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMFoodDeliveryPlaceNavigatorView *placeNavigatorView;

@property (nonatomic, strong) NSTimer *orderFetchTimer;

@end

@implementation NMFoodDeliveryPlaceTableViewController

- (void)loadView {
    [super loadView];
    [self initNavBar];
    
    self.view.backgroundColor = [NMColors lightGray];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    
    NMFoodDeliveryPlaceFooter *footerView = [[NMFoodDeliveryPlaceFooter alloc] init];
    footerView.translatesAutoresizingMaskIntoConstraints = NO;
    footerView.revenueLabel.text = @"Total Delivered: $550";
    [self.view addSubview:footerView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[footerView]|" options:(NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight) metrics:nil views:NSDictionaryOfVariableBindings(_tableView, footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:(NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight) metrics:nil views:NSDictionaryOfVariableBindings(_tableView, footerView)]];

    
    
    [self.tableView registerClass:[NMOrderTableViewCell class] forCellReuseIdentifier:NMOrderTableViewCellIdentifier];
    [self setTableViewHeader];
    [self startFetchingOrders];
}

- (void)setTableViewHeader {
    _placeNavigatorView = [[NMFoodDeliveryPlaceNavigatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), NMOrderLocationViewHeight)];
    _placeNavigatorView.deliveryPlaces = [NMFoodDeliveryPlace placesForCourier:NMCourier.currentCourier];
    _placeNavigatorView.delegate = self;
    self.tableView.tableHeaderView = _placeNavigatorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fetchedResultsController performFetch:nil];
}

- (NMFoodDeliveryPlace*)deliveryPlace {
    if (!_deliveryPlace) {
        _deliveryPlace = [NMFoodDeliveryPlace currentPlace];
    }
    return _deliveryPlace;
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
    
    NSString *path = [NSString stringWithFormat:@"food_delivery_places/%@/orders/%@", self.deliveryPlace.uid, order.uid];
    [[NMApi instance] PUT:path parameters:@{ @"state_id" : @(NMOrderStateDelivered) } completion:^(OVCResponse *response, NSError *error) {
        if ([response.result class] == [NMErrorApiModel class]) [response.result handleError];
    }];
}

#pragma mark - Place-specific actions


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


#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    
    NSPredicate *ordersPredicate = [NSPredicate predicateWithFormat:@"stateID = %@ AND place = %@ AND courier = %@", @(NMOrderStateActive), self.deliveryPlace.place, self.deliveryPlace.courier];
    
    _fetchedResultsController = [NMOrder MR_fetchAllSortedBy:@"placedAt" ascending:NO withPredicate:ordersPredicate groupBy:nil delegate:self];
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
        default:
            break;
    }
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
}

#pragma mark - Fetch Orders

- (void)startFetchingOrders {
    _orderFetchTimer = [NSTimer scheduledTimerWithTimeInterval:NMOrderFetchInterval target:self selector:@selector(fetchOrders) userInfo:nil repeats:YES];
    [self fetchOrders];
}

- (void)fetchOrders {
    [[NMApi instance] GET:[NSString stringWithFormat:@"food_delivery_places/%@/orders", self.deliveryPlace.uid] parameters:nil completion:NULL];
}

#pragma mark - De-alloc

- (void)dealloc {
    [_orderFetchTimer invalidate];
    _orderFetchTimer = nil;
    _deliveryPlace = nil;
    _placeNavigatorView.delegate = nil;
    _placeNavigatorView = nil;
    _fetchedResultsController = nil;
}



@end
