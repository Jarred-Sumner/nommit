//
//  NMNewDeliveryTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMShiftTableViewController.h"
#import "NMDeliveryPlaceHeaderView.h"
#import "NMOrderTableViewCell.h"
#import "NMDeliveryPlaceFooter.h"


static NSTimeInterval NMOrderFetchInterval = 5;
static NSString *NMOrderTableViewCellIdentifier = @"NMOrderTableViewCellIdentifier";

@interface NMShiftTableViewController ()

@property (nonatomic) NSUInteger placeIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NMDeliveryPlaceFooter *footerView;
@property (nonatomic, strong) UIButton *oldPlaceButton;
@property (nonatomic, strong) UILabel *headerLabel;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, copy) NSTimer *ordersTimer;

@end

@implementation NMShiftTableViewController

- (id)initWithShift:(NMShift *)shift {
    self = [super init];
    _shift = shift;
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Current Orders";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
    self.navigationItem.hidesBackButton = YES;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    [self countPendingOrders];
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
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            NMDeliveryPlaceHeaderView *headerView = (NMDeliveryPlaceHeaderView*)[self.tableView headerViewForSection:sectionIndex];
            [self configureHeaderView:headerView inSection:sectionIndex];
            break;
        } case NSFetchedResultsChangeDelete:
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
            
        case NSFetchedResultsChangeUpdate: {
            [self configureCell:(NMOrderTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [self configureHeaderView:(NMDeliveryPlaceHeaderView*)[self.tableView headerViewForSection:indexPath.section] inSection:indexPath.section];
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
    [self countPendingOrders];
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
    NMDeliveryPlaceHeaderView *view = [[NMDeliveryPlaceHeaderView alloc] initWithFrame:CGRectMake(0, 0, 273, 60)];
    [self configureHeaderView:view inSection:section];
    return view;
}

- (void)configureHeaderView:(NMDeliveryPlaceHeaderView*)view inSection:(NSInteger)section {
    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    view.backgroundColor = UIColorFromRGB(0xB00000);
    view.placeName.text = order.place.name;
    view.placeNumber.text = [NSString stringWithFormat:@"%ld", [order.deliveryPlace.index integerValue] + 1];
    [view.arrivalButton addTarget:self action:@selector(arrivedAtLocation:) forControlEvents:UIControlEventTouchUpInside];
    
    if (order.deliveryPlace.arrivesAt)
    [view setUrgency:NMDeliveryUrgencyHigh];
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
    
    NSString *phNo = @"9255968005";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Phone call errored. Try Again." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

#pragma mark - Refresh Orders

- (void)startRefreshingOrders {
    _ordersTimer = [NSTimer scheduledTimerWithTimeInterval:NMOrderFetchInterval target:self selector:@selector(refreshOrders) userInfo:nil repeats:YES];
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
            [this.fetchedResultsController performFetch:nil];
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

@end
