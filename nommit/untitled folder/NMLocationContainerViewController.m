//
//  NMLocationContainerViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLocationContainerViewController.h"
#import "NMLocationsTableViewController.h"

@interface NMLocationContainerViewController ()

@property (nonatomic, strong) NMLocationsTableViewController *tableViewController;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *originalArray;

@end

@implementation NMLocationContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Search Location";
    
    self.tableViewController = [[NMLocationsTableViewController alloc] init];
    [self nm_addChildViewController:self.tableViewController];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.tableViewController.searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;
    
    _originalArray = [NSMutableArray arrayWithObjects:@"Mudge", @"Donner", @"Stever", @"Morewood", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableViewController.view.frame = self.view.bounds;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [NMColors mainColor]};
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return YES;
}

- (void)nm_addChildViewController:(UIViewController *)controller {
    [controller beginAppearanceTransition:YES animated:NO];
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller didMoveToParentViewController:controller];
    [controller endAppearanceTransition];
}

- (void)nm_removeChildViewController:(UIViewController *)controller {
    if ([self.childViewControllers containsObject:controller]) {
        [controller beginAppearanceTransition:NO animated:NO];
        [controller willMoveToParentViewController:nil];
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
        [controller didMoveToParentViewController:nil];
        [controller endAppearanceTransition];
    }
}

#pragma mark -
#pragma mark UISearchDisplayDelegate

- (void)handleSearchForSearchString:(NSString *)searchString {
    searchResultsPlaces = [_originalArray copy];
    [self searchAutocompleteEntriesWithSubstring:searchString];
    [self.searchDisplayController.searchResultsTableView reloadData];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self handleSearchForSearchString:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

#pragma mark -
#pragma mark UISearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (![searchBar isFirstResponder]) {
        // User tapped the 'clear' button.
        shouldBeginEditing = NO;
        [self.searchController setActive:NO];
    }
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    if (shouldBeginEditing) {
        // Animate in the table view.
        NSTimeInterval animationDuration = 0.3;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
        self.searchDisplayController.searchResultsTableView.alpha = 1.0;
        [UIView commitAnimations];
        
        [self.searchDisplayController.searchBar setShowsCancelButton:YES animated:YES];
    }
    BOOL boolToReturn = shouldBeginEditing;
    shouldBeginEditing = YES;
    return boolToReturn;
}

#pragma mark - UITableViewDelegate
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [searchResultsPlaces count];
}

- (NSString *)placeAtIndexPath:(NSIndexPath *)indexPath {
    return [searchResultsPlaces objectAtIndex:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SPGooglePlacesAutocompleteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"GillSans" size:16.0];
    cell.textLabel.text = [searchResultsPlaces objectAtIndex:indexPath.row];
    return cell;
}

- (void)dismissSearchControllerWhileStayingActive {
    // Animate out the table view.
    NSTimeInterval animationDuration = 0.3;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    self.searchDisplayController.searchResultsTableView.alpha = 0.0;
    [UIView commitAnimations];
    
    [self.searchDisplayController.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchDisplayController.searchBar resignFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissSearchControllerWhileStayingActive];
    [self.searchDisplayController.searchResultsTableView deselectRowAtIndexPath:indexPath animated:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate setSelectedAddress:@"Mudge"];
    }];
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the searchResultsPlaces array
    // The items in this array is what will show up in the table view
    searchResultsPlaces = [NSMutableArray array];
    for(NSString *curString in _originalArray) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [searchResultsPlaces addObject:curString];
        }
    }
    if ([substring  isEqual: @""]) {
        searchResultsPlaces = [_originalArray copy];
    }
    [self.searchDisplayController.searchResultsTableView reloadData];
}


@end
