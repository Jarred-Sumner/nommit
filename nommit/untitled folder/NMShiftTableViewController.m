//
//  NMNewDeliveryTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMShiftTableViewController.h"
#import "NMOrderTableViewCell.h"
#import "NMDeliveryPlaceFooter.h"

#import "NMDeliveryPlacesTableViewController.h"


static NSTimeInterval NMOrderFetchInterval = 5;

static NSString *NMDeliveryPlaceHeaderReuseIdentifier = @"NMDeliveryPlaceHeaderReuseIdentifier";
static NSString *NMOrderTableViewCellIdentifier = @"NMOrderTableViewCellIdentifier";

@interface NMShiftTableViewController ()

@property (nonatomic) NSUInteger placeIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NMDeliveryPlaceFooter *footerView;
@property (nonatomic, strong) UIButton *oldPlaceButton;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *deliveryPlaces;

@property (nonatomic, copy) NSTimer *ordersTimer;
@property (nonatomic, copy) NSTimer *headersTimer;
@end

@implementation NMShiftTableViewController

- (id)initWithShift:(NMShift *)shift {
    self = [super init];
    self.shift = shift;
    return self;
}

- (void)setShift:(NMShift *)shift {
    _shift = shift;
    _deliveryPlaces = shift.activeDeliveryPlaces;
}


- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [NMColors lightGray];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 83, 0);
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    _headerLabel.font = [UIFont fontWithName:@"Avenir" size:18.0f];
    _headerLabel.textColor = UIColorFromRGB(0x666666);
    self.tableView.tableHeaderView = _headerLabel;
    
    [self.view addSubview:self.tableView];
    
    _footerView = [[NMDeliveryPlaceFooter alloc] init];
    _footerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_footerView.endShiftButton addTarget:self action:@selector(endShift) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_footerView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView]|" options:(NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight) metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];
    
    
    [self.tableView registerClass:[NMOrderTableViewCell class] forCellReuseIdentifier:NMOrderTableViewCellIdentifier];
    [self.tableView registerClass:[NMDeliveryPlaceHeaderView class] forHeaderFooterViewReuseIdentifier:NMDeliveryPlaceHeaderReuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Current Orders";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    [self calculateStats];
    
    // Reload the NSFetchedResultsController
    _fetchedResultsController = nil;
    [self.fetchedResultsController performFetch:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startRefreshingOrders];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self stopRefreshingOrders];
}

- (void)close {
    __block NMShiftTableViewController *this = self;
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Are you sure?" andMessage:@"Your shift is ongoing. New orders might come in, and you won't see them until you come back. You could be late."];
    [alert addButtonWithTitle:@"No" type:SIAlertViewButtonTypeCancel handler:NULL];
    [alert addButtonWithTitle:@"Yes" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        [this dismissViewControllerAnimated:YES completion:NULL];
    }];
    [alert show];
}

- (void)edit {
    NMDeliveryPlacesTableViewController *dps = [[NMDeliveryPlacesTableViewController alloc] initWithShift:self.shift];
    dps.delegate = self;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:dps];
    [self.navigationController presentViewController:navVC animated:YES completion:NULL];
}

- (void)didModifyShift:(NMShift *)shift {
    self.shift = shift;
}

#pragma mark - NSFetchedResultsControllerDelegate

- (NSFetchedResultsController*)fetchedResultsController {
    if (_fetchedResultsController) return _fetchedResultsController;
    
    NSPredicate *ordersPredicate = [NSPredicate predicateWithFormat:@"stateID in %@ AND courier = %@ AND deliveryPlace != nil", [NMOrder pendingStates], _shift.courier];
    
    _fetchedResultsController = [NMOrder MR_fetchAllGroupedBy:@"deliveryPlace.index" withPredicate:ordersPredicate sortedBy:@"deliveryPlace.index" ascending:YES];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];

            break;
        } case NSFetchedResultsChangeDelete: {
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
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
            
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(NMOrderTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        } case NSFetchedResultsChangeMove:
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMDeliveryPlaceHeaderView *view = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:NMDeliveryPlaceHeaderReuseIdentifier];
    view.delegate = self;
    view.index = @(section);
    
    [self configureHeaderView:view];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMOrderTableViewCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureHeaderView:(NMDeliveryPlaceHeaderView*)view {
    NMDeliveryPlace *deliveryPlace = self.deliveryPlaces[view.index.intValue];

    NSString *timeFormat = [NSString stringWithFormat:@"'%@' - mm:ss", deliveryPlace.place.name];
    [view.placeName setTimeFormat:timeFormat];
    view.placeNumber.text = [NSString stringWithFormat:@"%d", view.index.intValue + 1];
    view.eta = deliveryPlace.arrivesAt;

    [view setArrivalState:NMDeliveryArrivalStateArrived];
    
    [self setUrgencyForHeader:view];
}

- (void)configureCell:(NMOrderTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = order.user.name;
    cell.orderName.text = [NSString stringWithFormat:@"%@ - %@", order.quantity, order.food.title];
    cell.profileAvatar.profileID = order.user.facebookUID;

    [cell.callButton addTarget:self action:@selector(callUser:) forControlEvents:UIControlEventTouchUpInside];
    [cell.doneButton addTarget:self action:@selector(deliverOrder:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Order Actions

- (void)callUser:(id)sender
{
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForRowAtPoint:buttonOriginInTableView]];

    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",order.user.phone]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        [SVProgressHUD showErrorWithStatus:@"Cannot place phone calls on this device"];
    }
}

- (void)deliverOrder:(id)sender {
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    NMOrderTableViewCell *cell = (NMOrderTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];

    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.state = NMOrderTableViewCellStateDelivering;
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] PUT:[NSString stringWithFormat:@"orders/%@", order.uid] parameters:@{ @"state_id" : @(NMOrderStateDelivered) } completion:^(OVCResponse *response, NSError *error) {
        cell.state = NMOrderTableViewCellStatePending;
        if (error) {
            if ([response.result class] == [NMErrorApiModel class]) {
                [response.result handleError];
            } else {
                [NMErrorApiModel handleGenericError];
            }
        }
    }];
    
}

#pragma mark - Refresh Orders

- (void)startRefreshingOrders {
    [self refreshShift];
    _ordersTimer = [NSTimer scheduledTimerWithTimeInterval:NMOrderFetchInterval target:self selector:@selector(refreshShift) userInfo:nil repeats:YES];
}

- (void)stopRefreshingOrders {
    [_ordersTimer invalidate];
}

- (void)refreshOrders {
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"shifts/%@/orders", _shift.uid] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSMutableArray *models = [[NSMutableArray alloc] init];
            [response.result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                [models addObject:[MTLJSONAdapter modelOfClass:[NMOrderApiModel class] fromJSONDictionary:obj error:nil]];
            }];
            
            for (NMOrderApiModel *model in models) {
                NMOrder *order = [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:localContext error:nil];
                order.place = [NMPlace MR_findFirstByAttribute:@"uid" withValue:model.place.uid inContext:localContext];
                order.deliveryPlace = [order.place deliveryPlaceForShift:this.shift inContext:localContext];
            }
        } completion:^(BOOL success, NSError *error) {
            this.fetchedResultsController = nil;
            [this.fetchedResultsController performFetch:nil];
            [this.tableView reloadData];
            [this refreshSectionHeaders];
            [this calculateStats];
        }];
        
    }];
    
}
- (void)refreshShift {
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        __block NMShiftApiModel *shiftModel = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:nil];

        [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
            this.shift = [MTLManagedObjectAdapter managedObjectFromModel:shiftModel insertingIntoContext:localContext error:nil];
        } completion:^(BOOL success, NSError *error) {
            if (this.shift.state == NMShiftStateEnded) {
                [this didEndShift];
                return;
            }
            [this refreshOrders];
            
        }];
        
    }];
    
}

#pragma mark - Header

- (void)arrivedAtLocation:(id)button {
    UIButton *currentbutton = (UIButton *)button;
    if (_oldPlaceButton) {
        _oldPlaceButton.hidden = NO;
    }
    _oldPlaceButton = currentbutton;
    currentbutton.hidden = YES;
}

- (void)countPendingOrders {
    NSPredicate *pendingOrders = [NSPredicate predicateWithFormat:@"courier = %@ AND stateID in %@", NMCourier.currentCourier, [NMOrder pendingStates]];
    NSUInteger pendingCount = [NMOrder MR_countOfEntitiesWithPredicate:pendingOrders];
    _headerLabel.text = [NSString stringWithFormat:@"%@ Pending Orders", @(pendingCount)];
    
}

- (void)calculateStats {
    [self countPendingOrders];
    _footerView.revenueLabel.text = [NSString stringWithFormat:@"Total Delivered: $%@", @([_shift.revenueGeneratedInCents doubleValue] / 100.0)];
}

- (void)refreshSectionHeaders {
    if (self.tableView.numberOfSections > 0) {
        // Update all the section views
        for (int sectionIndex = 0; sectionIndex < [self.deliveryPlaces count]; sectionIndex++) {
            NMDeliveryPlaceHeaderView *headerView = (NMDeliveryPlaceHeaderView*)[self.tableView headerViewForSection:sectionIndex];
            headerView.index = @(sectionIndex);
            [self configureHeaderView:headerView];
        }
    }
}

#pragma mark - NMDeliveryPlaceHeaderViewDelegate

- (void)toggleStateForHeader:(NMDeliveryPlaceHeaderView *)header {
    NMDeliveryPlace *deliveryPlace = self.deliveryPlaces[header.index.intValue];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"delivery_place_id"] = deliveryPlace.uid;
    if (deliveryPlace.state == NMDeliveryPlaceStateArrived) {
        params[@"delivery_place_state_id"] = @(NMDeliveryPlaceStateReady);
    } else if (deliveryPlace.state == NMDeliveryPlaceStateReady || deliveryPlace.state == NMDeliveryPlaceStateHalted) {
        params[@"delivery_place_state_id"] = @(NMDeliveryPlaceStateArrived);
    }
    
    [header setArrivalState:NMDeliveryArrivalStatePending];
    
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:params completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        if (!error) {
            [SVProgressHUD showWithStatus:@"Notified!" maskType:SVProgressHUDMaskTypeBlack];
            [SVProgressHUD showSuccessWithStatus:@"Notified!"];
        }
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NMShiftApiModel *model = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:nil];
            [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:localContext error:nil];
        } completion:^(BOOL success, NSError *error) {
        }];
        
        
    }];
}

#pragma mark - End Shift

- (void)endShift {
    [SVProgressHUD showWithStatus:@"Ending Shift..." maskType:SVProgressHUDMaskTypeBlack];
    
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:@{ @"state_id" : @(NMShiftStateEnded) } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        if (error) return;

        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NMShiftApiModel *model = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:nil];
            [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:localContext error:nil];
        } completion:^(BOOL success, NSError *error) {
            if (this.shift.state == NMShiftStateEnded) [this didEndShift];
        }];
        
    }];
}

- (void)didEndShift {
    [SVProgressHUD showSuccessWithStatus:@"Ended!"];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Urgency

- (void)setUrgencyForHeader:(NMDeliveryPlaceHeaderView*)header {
    NMDeliveryPlace *deliveryPlace = self.deliveryPlaces[header.index.intValue];
    
    NMDeliveryUrgencyState urgency;
    if ([self.deliveryPlaces count] < header.index.intValue) {
        NMDeliveryPlace *next = self.deliveryPlaces[header.index.intValue + 1];
        urgency = [self urgencyFromDate:deliveryPlace.arrivesAt toDate:next.arrivesAt];
    } else {
        // Default time is 15 minutes
        urgency = [self urgencyFromDate:[deliveryPlace.arrivesAt dateByAddingTimeInterval:-(60 * 15)] toDate:deliveryPlace.arrivesAt];
    }
    [header setUrgency:urgency];
}

- (NMDeliveryUrgencyState)urgencyFromDate:(NSDate*)from toDate:(NSDate*)to {
    NSNumber *fromSeconds = @(abs([from timeIntervalSinceNow]));
    NSNumber *toSeconds = @(abs([from timeIntervalSinceDate:to]));
    
    if (fromSeconds.doubleValue / toSeconds.doubleValue < 0.25) {
        return NMDeliveryUrgencyStateLow;
    } else if (fromSeconds.doubleValue / toSeconds.doubleValue < 0.75) {
        return NMDeliveryUrgencyStateMedium;
    } else return NMDeliveryUrgencyStateHigh;
}

- (void)dealloc {
    [_ordersTimer invalidate];
    [_headersTimer invalidate];
}

@end
