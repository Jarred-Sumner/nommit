//
//  NMPickPlacesTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryPlacesTableViewController.h"
#import "NMDeliveryPlaceTableViewController.h"
#import "NMPlaceTableViewCell.h"

#import <SIAlertView/SIAlertView.h>

@interface NMDeliveryPlacesTableViewController ()

@property (nonatomic, strong) NMShift *shift;
@property (nonatomic, strong) NSMutableOrderedSet *placeIDs;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation NMDeliveryPlacesTableViewController

static NSString *NMCellIdentifier = @"NMCellIdentifier";

- (id)initWithShift:(NMShift *)shift {
    self = [super initWithStyle:UITableViewStylePlain];
    self.shift = shift;
    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NMPlaceTableViewCell class] forCellReuseIdentifier:NMCellIdentifier];
    [self setupRefreshing];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Pick Delivery Places";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didTapCancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(didTapStartShift:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)setShift:(NMShift *)shift {
    _shift = shift;
    self.placeIDs = [[NSMutableOrderedSet alloc] initWithCapacity:1];
    if (shift) {
        NSArray *places = [NMDeliveryPlace MR_findAllSortedBy:@"index" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"shift = %@", shift]];
        for (NMDeliveryPlace *dp in places) {
            [self.placeIDs addObject:dp.place.uid];
        }
    }
    
}

- (void)didTapCancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    [self.fetchedResultsController performFetch:nil];

}

#pragma mark - Refresh

- (void)setupRefreshing {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPlaces) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [self refreshPlaces];
}

- (void)refreshPlaces {
    __weak NMDeliveryPlacesTableViewController *this = self;
    [self.refreshControl beginRefreshing];
    
    [[NMApi instance] GET:@"places" parameters:nil completion:^(OVCResponse *response, NSError *error) {
        if (error) {
            [response.result handleError];
        }
        [this.refreshControl endRefreshing];
    }];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;

    // We want to show all the places the Seller could be delivering to, but isn't.
    // Those are defined as Places without active deliveryPlaces associated with the seller
    
    // YUCK
    
    // Places that:
    // Have no deliveryPlaces
    // OR
    // They don't have a courier part of the seller
    // AND
    // The deliveryPlace state is not ready and not arrived
    NSPredicate *deliveryPlaces = [NSPredicate predicateWithFormat:@"(deliveryPlaces.@count == 0) OR  (SUBQUERY(deliveryPlaces, $dp, $dp.shift.courier IN %@ AND $dp.shift.courier != %@ AND ($dp.stateID == %@ OR $dp.stateID == %@) AND $dp.shift.stateID == %@).@count == 0)", NMCourier.currentCourier.seller.couriers, NMCourier.currentCourier, @(NMShiftStateActive), @(NMDeliveryPlaceStateReady), @(NMDeliveryPlaceStateArrived)];
    
    _fetchedResultsController = [NMPlace MR_fetchAllSortedBy:@"name" ascending:YES withPredicate:deliveryPlaces groupBy:nil delegate: self];
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
            [self configureCell:(NMPlaceTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NMPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMCellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NMPlaceTableViewCell *cell = (NMPlaceTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];

    if ([self isCellActiveAtIndexPath:indexPath]) {
        SIAlertView *alert = [[SIAlertView alloc] initWithTitle:@"Can't Stop Deliveries" andMessage:[NSString stringWithFormat:@"Can't stop delivering to %@ until your shift ends.", place.name]];
        [alert addButtonWithTitle:@"Close" type:SIAlertViewButtonTypeDestructive handler:NULL];
        [alert show];
        return;
    }
    
    if (![self.placeIDs containsObject:place.uid]) {
        cell.iconImageView.hidden = NO;
        [self.placeIDs addObject:place.uid];
    } else {
        cell.iconImageView.hidden = YES;
        [self.placeIDs removeObject:place.uid];

    }

}

- (void)configureCell:(NMPlaceTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.placeLabel.text = place.name;
    

    if ([self isCellActiveAtIndexPath:indexPath] || [self.placeIDs containsObject:place.uid]) {
        [self.placeIDs addObject:place.uid];
        cell.iconImageView.hidden = NO;
    } else if (!cell.selected) {
        cell.iconImageView.hidden = YES;
    }
    
}

- (BOOL)isCellActiveAtIndexPath:(NSIndexPath*)indexPath {
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"place = %@ AND shift.courier = %@ AND (shift.stateID = %@ OR shift.stateID = %@)", place, [NMCourier currentCourier], @(NMShiftStateActive), @(NMShiftStateHalted)];
    return [NMDeliveryPlace MR_countOfEntitiesWithPredicate:predicate] > 0;
}

#pragma mark - Shifts

- (void)didTapStartShift:(id)sender
{
    if (_shift) {
        [self updateShift];
    } else {
        [self createShift];
    }
    
}

- (void)createShift {
    [SVProgressHUD showWithStatus:@"Starting Shift..." maskType:SVProgressHUDMaskTypeBlack];
    __block NMDeliveryPlacesTableViewController *this = self;
    
    [[NMApi instance] POST:@"shifts" parameters:@{ @"place_ids": [self.placeIDs array] } completion:^(OVCResponse *response, NSError *error) {
        if (error) {
            [response.result handleError];
        } else {
            NMShift *shift = [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:[NSManagedObjectContext MR_defaultContext] error:nil];
            this.shift = shift;
            
            NMDeliveryPlaceTableViewController *dpTV = [[NMDeliveryPlaceTableViewController alloc] initWithShift:shift];
            [self.navigationController pushViewController:dpTV animated:YES];
            [SVProgressHUD showSuccessWithStatus:@"Started Shift!"];
        }
    }];
}

- (void)updateShift {
    [SVProgressHUD showWithStatus:@"Updating Shift..." maskType:SVProgressHUDMaskTypeBlack];
    __block NMDeliveryPlacesTableViewController *this = self;
    
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:@{ @"place_ids": [self.placeIDs array] } completion:^(OVCResponse *response, NSError *error) {
        if (error) {
            [response.result handleError];
        } else {
            NMShift *shift = [MTLManagedObjectAdapter managedObjectFromModel:response.result insertingIntoContext:[NSManagedObjectContext MR_defaultContext] error:nil];
            this.shift = shift;
            
            NMDeliveryPlaceTableViewController *dpTV = [[NMDeliveryPlaceTableViewController alloc] initWithShift:shift];
            [self.navigationController pushViewController:dpTV animated:YES];
            [SVProgressHUD showSuccessWithStatus:@"Updated Shift!"];
        }
    }];
}


@end