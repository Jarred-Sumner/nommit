//
//  NMLocationsTableViewController.m
//  nommit
//
//  Created by Jarred Sumner on 9/22/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMPlacesTableViewController.h"
#import "NMListTableViewCell.h"
#import "NMNoFoodView.h"
#import "NMFooterRequestView.h"
#import "NMSupportViewController.h"


@interface NMPlacesTableViewController ()

@property (nonatomic, strong) NMNoFoodView *noFoodView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation NMPlacesTableViewController

static NSString *NMPlaceTableViewCellKey = @"NMPlaceTableViewCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    [self setupRefreshing];
    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NMListTableViewCell class] forCellReuseIdentifier:NMPlaceTableViewCellKey];
    
    [self setupFooter];
    
    return self;
}

- (void)setupFooter {
    NMFooterRequestView *view = [[NMFooterRequestView alloc] initWithText:@"Missing your delivery location? Request it." withUnderlinedString:@"Request it." withFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    view.footerText.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerTapped)];
    [view.footerText addGestureRecognizer:tapGesture];
    
    self.tableView.tableFooterView = view;
}

- (void)footerTapped {
    NMSupportViewController *supportView = [[NMSupportViewController alloc] initModal];
    NMNavigationController *navController =
    [[NMNavigationController alloc] initWithRootViewController:supportView];
    [self presentViewController:navController animated:YES completion:nil];
}

- (void)loadView {
    [super loadView];

    _noFoodView = [[NMNoFoodView alloc] initWithFrame:self.tableView.bounds];
    _noFoodView.hidden = YES;

    [self.tableView addSubview:_noFoodView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Delivery Locations";
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:UIColorFromRGB(0x9C9C9C) forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)] forKey:UITextAttributeTextShadowOffset];
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    [self.fetchedResultsController performFetch:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshPlaces];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Refresh Places

- (void)setupRefreshing {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshPlaces) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)refreshPlaces {
    __weak NMPlacesTableViewController *this = self;
    [self.refreshControl beginRefreshing];
    
    [NMPlace refreshAllWithCompletion:^(id response, NSError *error) {
        [this.refreshControl endRefreshing];
        [this.tableView reloadData];
    }];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"foodCount > 0 AND school = %@", [NMUser currentUser].school];
    _fetchedResultsController = [NMPlace MR_fetchAllSortedBy:@"name" ascending:YES withPredicate:predicate groupBy:nil delegate:self];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    if ([sectionInfo numberOfObjects] == 0) {
        _noFoodView.hidden = NO;
        self.tableView.tableFooterView.hidden = YES;
    } else {
        _noFoodView.hidden = YES;
        self.tableView.tableFooterView.hidden = NO;
    }
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMPlaceTableViewCellKey];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NMListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NMPlace *place = [self.fetchedResultsController objectAtIndexPath:indexPath];

    NSString *placeString = place.name;
    if ([placeString length] > 21) {
        placeString = [NSString stringWithFormat:@"%@...", [placeString substringToIndex:21]];
    }
    
    cell.textLabel.text = placeString;
    cell.accessoryLabel.text = [NSString stringWithFormat:@"%@", place.foodCount];
    cell.iconImageView.hidden = !(place.foodCount.integerValue > 0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NMPlace *place = (NMPlace*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    _foodsVC.place = place;
    NMPlace.activePlace = place;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
