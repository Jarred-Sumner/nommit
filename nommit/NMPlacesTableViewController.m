//
//  NMLocationsTableViewController.m
//  nommit
//
//  Created by Jarred Sumner on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPlacesTableViewController.h"
#import "NMPlaceTableViewCell.h"

@interface NMPlacesTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
//@property (nonatomic, strong) UISearchBar *searchBar;
//@property (nonatomic, strong) UISearchDisplayController * searchController;

@end

@implementation NMPlacesTableViewController

static NSString *NMPlaceTableViewCellKey = @"NMPlaceTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NMPlaceTableViewCell class] forCellReuseIdentifier:NMPlaceTableViewCellKey];
    [self.fetchedResultsController performFetch:nil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.fetchedResultsController performFetch:nil];
    self.title = @"Delivery Location";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)viewDidLoad {
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodCount > 0"];
    _fetchedResultsController = [NMPlace MR_fetchAllSortedBy:@"foodCount" ascending:NO withPredicate:predicate groupBy:nil delegate:self];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMPlaceTableViewCellKey];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NMPlaceTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];

    NSString *placeString = place.name;
    if ([placeString length] > 21) {
        placeString = [NSString stringWithFormat:@"%@...", [placeString substringToIndex:21]];
    }
    
    cell.placeLabel.text = placeString;
    cell.numberOfFoodAvailableLabel.text = [NSString stringWithFormat:@"%@", place.foodCount];
    cell.iconImageView.hidden = !(place.foodCount.integerValue > 0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    __weak NMPlace *place = (NMPlace*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    _foodsVC.place = place;

    [self dismissViewControllerAnimated:YES completion:^{
        NMPlace.activePlace = place;
    }];
}

@end
