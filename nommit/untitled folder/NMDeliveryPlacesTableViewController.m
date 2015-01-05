//
//  NMPickPlacesTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMDeliveryPlacesTableViewController.h"
#import "NMShiftTableViewController.h"
#import "NMListTableViewCell.h"

#import <SIAlertView/SIAlertView.h>

@interface NMDeliveryPlacesTableViewController ()

@property (nonatomic, strong) NMShiftApiModel *shift;
@property (nonatomic, strong) NSMutableOrderedSet *placeIDs;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation NMDeliveryPlacesTableViewController

static NSString *NMCellIdentifier = @"NMCellIdentifier";

- (id)initWithShift:(NMShiftApiModel *)shift {
    self = [self initWithStyle:UITableViewStylePlain];
    self.shift = shift;
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    self.placeIDs = [[NSMutableOrderedSet alloc] initWithCapacity:1];

    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.tableView registerClass:[NMListTableViewCell class] forCellReuseIdentifier:NMCellIdentifier];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Pick Delivery Places";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:UIColorFromRGB(0x9C9C9C) forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)] forKey:UITextAttributeTextShadowOffset];

    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didTapCancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(didTapStartShift:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;

    [self.fetchedResultsController performFetch:nil];
    [self setupRefreshing];
}

- (void)setShift:(NMShiftApiModel *)shift {
    _shift = shift;
    if (shift) {
        self.placeIDs = [[NSMutableOrderedSet alloc] initWithArray:shift.placeIDs];
    }
    
}

- (void)didTapCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
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
    
    [[NMApi instance] GET:@"places" parameters:@{ @"delivery" : @1 } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSArray *models = [MTLJSONAdapter modelsOfClass:[NMPlaceApiModel class] fromJSONArray:response.result error:nil];
            for (NMPlaceApiModel *model in models) {
                [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:localContext error:nil];
            }
        } completion:^(BOOL success, NSError *error) {
            [this.refreshControl endRefreshing];
        }];
        
    }];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;

    _fetchedResultsController = [NMPlace MR_fetchAllSortedBy:@"name" ascending:YES withPredicate:[NSPredicate predicateWithFormat:@"school = %@", [NMUser currentUser].school] groupBy:nil delegate:self];
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
            [self configureCell:(NMListTableViewCell*)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
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
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NMListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMCellIdentifier];
    if (!cell) {
        cell = [[NMListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NMCellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NMListTableViewCell *cell = (NMListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];

    if ([self.placeIDs containsObject:place.uid]) {
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

- (void)configureCell:(NMListTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = place.name;

    if ([self.placeIDs containsObject:place.uid]) {
        [self.placeIDs addObject:place.uid];
        cell.iconImageView.hidden = NO;
    } else if (!cell.selected) {
        cell.iconImageView.hidden = YES;
    }
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
    
    [[NMApi instance] POST:@"shifts" parameters:@{ @"place_ids": [self.placeIDs array] } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        __block NMShiftApiModel *shiftModel = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            NMShiftTableViewController *dpTV = [[NMShiftTableViewController alloc] initWithShift:shiftModel];
            [this.navigationController pushViewController:dpTV animated:YES];
            [SVProgressHUD showSuccessWithStatus:@"Started Shift!"];
            [[Mixpanel sharedInstance] track:@"Started Shift"];
        });
    }];
}

- (void)updateShift {
    [SVProgressHUD showWithStatus:@"Updating Shift..." maskType:SVProgressHUDMaskTypeBlack];
    __block NMDeliveryPlacesTableViewController *this = self;
    
    [[NMApi instance] PUT:[NSString stringWithFormat:@"shifts/%@", _shift.uid] parameters:@{ @"place_ids": [self.placeIDs array] } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __block NMShiftApiModel *shiftModel = [MTLJSONAdapter modelOfClass:[NMShiftApiModel class] fromJSONDictionary:response.result error:nil];
            this.shift = shiftModel;

            [SVProgressHUD showSuccessWithStatus:@"Updated Shift!"];
            [this dismissViewControllerAnimated:YES completion:NULL];
        });

    }];
}

#pragma mark - Dealloc

- (void)dealloc {
    _fetchedResultsController.delegate = nil;
    _fetchedResultsController = nil;
    _shift = nil;
    _placeIDs = nil;
}


@end
