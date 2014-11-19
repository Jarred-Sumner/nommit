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

@property (nonatomic, strong) NSArray *deliveryPlaces;
@property (nonatomic, strong) NSArray *nextDeliveryPlaces;
@property (nonatomic, strong) NSNumber *numberOfOrders;
@property (nonatomic, strong) NSNumber *revenueGeneratedInCents;

@property (nonatomic, copy) NSTimer *ordersTimer;
@property (nonatomic, copy) NSTimer *headersTimer;


@end

@implementation NMShiftTableViewController

- (id)initWithShiftID:(NSNumber *)shiftID {
    self = [super init];
    self.shiftID = shiftID;
    return self;
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
    NMDeliveryPlacesTableViewController *dps = [[NMDeliveryPlacesTableViewController alloc] initWithShift:[NMShift MR_findFirstByAttribute:@"uid" withValue:_shiftID]];
    dps.delegate = self;
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:dps];
    [self.navigationController presentViewController:navVC animated:YES completion:NULL];
}

- (void)didModifyShift:(NMShift *)shift {
    self.shiftID = shift.uid;
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.deliveryPlaces.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NMDeliveryPlaceApiModel *place = self.deliveryPlaces[section];
    return place.pendingOrders.count;
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
    NMOrderApiModel *order = [[self.deliveryPlaces[indexPath.section] pendingOrders] objectAtIndex:indexPath.row];
    
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
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    NMOrderApiModel *order = [self.deliveryPlaces[indexPath.section] pendingOrders][indexPath.row];

    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",order.user.phone]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else {
        [SVProgressHUD showErrorWithStatus:@"Cannot place phone calls on this device"];
    }
}

- (void)deliverOrder:(id)sender {
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    
    __block NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonOriginInTableView];
    NMOrderTableViewCell *cell = (NMOrderTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    __block NMDeliveryPlaceApiModel *deliveryPlace = self.deliveryPlaces[indexPath.section];
    __block NMOrderApiModel *order = [self orderForIndexPath:indexPath];
    
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
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [this.tableView beginUpdates];
                [this.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationFade];
                [deliveryPlace.pendingOrders removeObject:order];
                
                if (deliveryPlace.pendingOrders.count == 0) {
                    NSMutableArray *dps = [[NSMutableArray alloc] init];
                    for (NMDeliveryPlace *dp in [this.deliveryPlaces reverseObjectEnumerator]) {
                        if (![dp.uid isEqualToNumber:deliveryPlace.uid]) [dps addObject:dp];
                    }
                    this.deliveryPlaces = dps;
                    [this.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
                }
                [this.tableView endUpdates];
                
            });
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
    [[NMApi instance] GET:[NSString stringWithFormat:@"shifts/%@/orders", _shiftID] parameters:nil completion:^(OVCResponse *response, NSError *error) {
        
        NSArray *models = [MTLJSONAdapter modelsOfClass:[NMOrderApiModel class] fromJSONArray:response.result error:nil];
        NSSet *visibleStates = [NSSet setWithArray:@[ @(NMOrderStateActive), @(NMOrderStateArrived) ]];
        NSUInteger numberOfOrders = 0;
        for (NMDeliveryPlaceApiModel *dp in this.nextDeliveryPlaces) {
            dp.pendingOrders = [[NSMutableOrderedSet alloc] init];
            for (NMOrderApiModel *order in models) {
                if ([order.place.uid isEqual:dp.place.uid] && [visibleStates member:order.stateID]) {
                    [dp.pendingOrders addObject:order];
                    numberOfOrders++;
                }
            }
            NSSortDescriptor *ordering = [[NSSortDescriptor alloc] initWithKey:@"placedAt" ascending:YES];
            dp.pendingOrders = [[NSMutableOrderedSet alloc] initWithArray:[dp.pendingOrders sortedArrayUsingDescriptors:@[ordering]]];
            
        }
        this.numberOfOrders = @(numberOfOrders);
        this.deliveryPlaces = this.nextDeliveryPlaces;
        [this.tableView reloadData];
        [this calculateStats];
        
        
        
    }];
    
}
- (void)refreshShift {
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"shifts/%@", _shiftID] parameters:nil completion:^(OVCResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
            __block NMShiftApiModel *shiftModel = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:&error];
            this.revenueGeneratedInCents = shiftModel.revenueGeneratedInCents;
            
            [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
                NSError *error;
                [MTLManagedObjectAdapter managedObjectFromModel:shiftModel insertingIntoContext:localContext error:&error];
                NSLog(@"Error: %@", error);
            }];
            
            NSMutableArray *dps = [[NSMutableArray alloc] init];
            NSSet *visibleStates = [NSSet setWithArray:@[ @(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateReady), @(NMDeliveryPlaceStateHalted) ]];
            for (NMDeliveryPlaceApiModel *dp in shiftModel.deliveryPlaces) {

                if ([visibleStates member:dp.stateID]) {
                    [dps addObject:dp];
                }
            }
            NSSortDescriptor *key = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES ];
            this.nextDeliveryPlaces = [dps sortedArrayUsingDescriptors:@[key]];
            [this refreshOrders];
        }
    }];
    
}

- (NMOrderApiModel*)orderForIndexPath:(NSIndexPath*)indexPath {
    NMDeliveryPlaceApiModel *dp = self.deliveryPlaces[indexPath.section];
    return [dp.pendingOrders objectAtIndex:indexPath.row];
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
    _headerLabel.text = [NSString stringWithFormat:@"%@ Pending Orders", _numberOfOrders.intValue > 0 ? _numberOfOrders : @"0"];
    
}

- (void)calculateStats {
    [self countPendingOrders];
    
    _footerView.revenueLabel.text = [NSString stringWithFormat:@"Total Delivered: $%@", @([_revenueGeneratedInCents doubleValue] / 100.0)];
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
    NMDeliveryPlaceApiModel *deliveryPlace = self.deliveryPlaces[header.index.intValue];

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"delivery_place_id"] = deliveryPlace.uid;
    if ([deliveryPlace.stateID integerValue] == NMDeliveryPlaceStateArrived) {
        params[@"delivery_place_state_id"] = @(NMDeliveryPlaceStateReady);
    } else if ([deliveryPlace.stateID integerValue] == NMDeliveryPlaceStateReady || [deliveryPlace.stateID integerValue] == NMDeliveryPlaceStateHalted) {
        params[@"delivery_place_state_id"] = @(NMDeliveryPlaceStateArrived);
    }
    
    [header setArrivalState:NMDeliveryArrivalStatePending];
    
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shiftID] parameters:params completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
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
    
    SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"End Shift?" andMessage:@"Are you sure you want to end your shift? This will stop new orders from coming in to your selected delivery places"];
    [alert addButtonWithTitle:@"No" type:SIAlertViewButtonTypeCancel handler:NULL];
    [alert addButtonWithTitle:@"I'm Sure" type:SIAlertViewButtonTypeDestructive handler:^(SIAlertView *alertView) {
        
        [self sendEndShift];
        
    }];
    [alert show];
}

- (void)sendEndShift {
    [SVProgressHUD showWithStatus:@"Ending Shift..." maskType:SVProgressHUDMaskTypeBlack];
    
    __block NMShiftTableViewController *this = self;
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shiftID] parameters:@{ @"state_id" : @(NMShiftStateEnded) } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        if (error) return;
        
        __block NMShiftApiModel *model = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:nil];
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:localContext error:nil];
        } completion:^(BOOL success, NSError *error) {
            if ([model.stateID isEqualToNumber:@(NMShiftStateEnded)]) [this didEndShift];
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
