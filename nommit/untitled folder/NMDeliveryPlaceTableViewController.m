//
//  NMFoodOrdersTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryPlaceTableViewController.h"
#import "NMDeliveryPlaceNavigatorView.h"
#import "NMOrderTableViewCell.h"
#import "NMMenuNavigationController.h"
#import "NMDeliveryPlaceFooter.h"

#import <SIAlertView/SIAlertView.h>

static NSTimeInterval NMOrderFetchInterval = 5;

static NSString *NMOrderTableViewCellIdentifier = @"NMOrderTableViewCellIdentifier";

@interface NMDeliveryPlaceTableViewController() <NMDeliveryPlaceNavigatorDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMDeliveryPlaceNavigatorView *placeNavigatorView;
@property (nonatomic, strong) NMDeliveryPlaceFooter *footerView;

@property (nonatomic, strong) NSTimer *orderFetchTimer;

@property (nonatomic) NSUInteger placeIndex;

@end

@implementation NMDeliveryPlaceTableViewController

- (id)initWithShift:(NMShift *)shift {
    self = [super init];
    _shift = shift;
    return self;
}

- (void)loadView {
    [super loadView];
    // [self initNavBar];
    self.view.backgroundColor = [NMColors lightGray];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    
    _footerView = [[NMDeliveryPlaceFooter alloc] init];
    _footerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_footerView.endShiftButton addTarget:self action:@selector(endShift) forControlEvents:UIControlEventTouchUpInside];
    [_footerView.hereButton addTarget:self action:@selector(imHere) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_footerView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView]|" options:(NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight) metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];

    
    [self.tableView registerClass:[NMOrderTableViewCell class] forCellReuseIdentifier:NMOrderTableViewCellIdentifier];
    [self setTableViewHeader];
}

- (void)setTableViewHeader {
    _placeNavigatorView = [[NMDeliveryPlaceNavigatorView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.tableView.frame), NMOrderLocationViewHeight) deliveryPlaces:self.deliveryPlaces];
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
    self.title = @"Current Orders";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};

    [_placeNavigatorView startUpdating];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.fetchedResultsController.delegate = nil;
    _fetchedResultsController = nil;
    
    [_orderFetchTimer invalidate];
    _orderFetchTimer = nil;
    
    [_placeNavigatorView stopUpdating];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) return _fetchedResultsController;
    NSLog(@"Reloading Fetch Results Controller!");

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courier IN %@ AND place = %@ AND stateID IN %@", [[NMUser currentUser] couriers], self.place, @[@(NMOrderStateActive), @(NMOrderStateArrived)]];
    NSFetchRequest *request = [NMOrder MR_requestAllSortedBy:@"placedAt" ascending:NO withPredicate:predicate];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext MR_defaultContext] sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
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
    NMOrderTableViewCell *cell = (NMOrderTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.doneButton.hidden = YES;
    cell.spinnerView.hidden = NO;
    [cell.spinnerView startAnimating];
    
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
    
    [[NMApi instance] PUT:path parameters:@{ @"state_id" : @(NMOrderStateDelivered) } completionWithErrorHandling:NULL];
}

#pragma mark - Shift

- (void)setShift:(NMShift *)shift {
    if (shift && shift.state != NMShiftStateEnded) {
        _deliveryPlaces = nil;
        _shift = shift;
        
        [_placeNavigatorView stopUpdating];
        _placeNavigatorView.deliveryPlaces = self.deliveryPlaces;
        [_placeNavigatorView startUpdating];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }

}

- (void)fetchShift {
    
    __block NMDeliveryPlaceTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:nil completion:^(OVCResponse *response, NSError *error) {
            this.shift = [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:[[NMApi instance] managedObjectContext] error:nil];

        
    }];
}

#pragma mark - Place-specific actions

- (NMPlace*)place {
    return self.deliveryPlace.place;
}

- (NSArray*)deliveryPlaces {
    if (!_deliveryPlaces) {
        _deliveryPlaces = _shift.sortedDeliveryPlaces;
    }
    return _deliveryPlaces;
}

- (NMDeliveryPlace*)deliveryPlace {
    return self.deliveryPlaces[_placeIndex];
}

- (void)didNavigateToDeliveryPlaceAtIndex:(NSUInteger)index {
    _fetchedResultsController.delegate = nil;
    _fetchedResultsController = nil;
    
    _placeIndex = index;
    
    [self fetchOrders];
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
}


#pragma mark - Navigation

- (void)initNavBar
{
    self.navigationController.navigationBar.topItem.title = @"Places";
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    self.navigationController.navigationBarHidden = NO;
    
}

#pragma mark - Footer View

- (void)updateRevenueText {
    self.footerView.revenueLabel.text = [NSString stringWithFormat:@"Total Delivered: $%@", @(_shift.revenueGeneratedInCentsValue / 100)];
}

- (void)endShift {
    __block NMDeliveryPlaceTableViewController *this = self;
    if (_shift.state == NMShiftStateActive) {
        [SVProgressHUD showWithStatus:@"Preventing New Orders..." maskType:SVProgressHUDMaskTypeBlack];
        
        NSString *path = [NSString stringWithFormat:@"shifts/%@", _shift.uid];
        [[NMApi instance] PUT:path parameters:@{ @"state_id" : @(NMShiftStateHalted) } completionWithErrorHandling:^(id response, NSError *error) {
            
            if ([_shift hasPendingDeliveries]) {
                [SVProgressHUD dismiss];
                
                NSNumber *pendingOrders = [self.shift countOfPendingDeliveries];
                NSString *message = [NSString stringWithFormat:@"Stopped new orders, but please deliver the remaining %@ orders", pendingOrders];
                SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Finish Deliveries" andMessage:message];
                [alert show];
            } else {
                [this endShift];
            }

        }];
    } else if (_shift.state == NMShiftStateHalted) {
        
        [SVProgressHUD showWithStatus:@"Ending Shift..." maskType:SVProgressHUDMaskTypeBlack];
        [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:@{ @"state_id" : @(NMShiftStateEnded) } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
                [SVProgressHUD showSuccessWithStatus:@"Shift Ended!"];
                [this.navigationController dismissViewControllerAnimated:YES completion:NULL];
        }];
    }
    
}

- (void)imHere {
    __block NMDeliveryPlaceTableViewController *this = self;
    [SVProgressHUD showWithStatus:@"Notifying Customers..." maskType:SVProgressHUDMaskTypeBlack];
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:@{ @"delivery_place_id": self.deliveryPlace.uid, @"delivery_place_state_id" : @(NMDeliveryPlaceStateArrived) } completionWithErrorHandling:^(OVCResponse * response, NSError *error) {
            NMShift *shift = [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:[[NMApi instance] managedObjectContext] error:&error];
            this.shift = shift;
            [SVProgressHUD showSuccessWithStatus:@"Notified!"];
    }];
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
    _deliveryPlaces = nil;
    _placeNavigatorView.delegate = nil;
    _placeNavigatorView = nil;
    _fetchedResultsController.delegate = nil;
    _fetchedResultsController = nil;
}



@end
