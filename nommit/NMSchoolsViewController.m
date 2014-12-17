//
//  NMSchoolsVewController.m
//  nommit
//
//  Created by Jarred Sumner on 12/16/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMListTableViewCell.h"
#import "NMSchoolsViewController.h"

NSString *NMSchoolTableViewCellKey = @"NMSchoolTableViewCellKey";

@interface NMSchoolsViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMListTableViewCell *selectedCell;

@end

@implementation NMSchoolsViewController

- (id)initWithCompletionBlock:(NMSchoolsCompletionBlock)completionBlock {
    self = [super initWithStyle:UITableViewStylePlain];
    _completionBlock = completionBlock;
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NMListTableViewCell class] forCellReuseIdentifier:NMSchoolTableViewCellKey];
    
    [self setupRefreshing];
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refresh];
}

#pragma mark - Refresh Content

- (void)setupRefreshing {
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)refresh {
    __weak NMSchoolsViewController *this = self;
    [self.refreshControl beginRefreshing];
    [[NMApi instance] GET:@"schools" parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        [this.refreshControl endRefreshing];
    }];
}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) return _fetchedResultsController;
    _fetchedResultsController = [NMSchool MR_fetchAllSortedBy:@"name" ascending:YES withPredicate:nil groupBy:nil delegate:self];
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
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMSchoolTableViewCellKey];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NMListTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NMSchool *school = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *name = school.name;
    if ([name length] > 21) {
        name = [NSString stringWithFormat:@"%@...", [name substringToIndex:21]];
    }
    
    cell.textLabel.text = name;
    cell.accessoryLabel.hidden = YES;

    if ([[[[NMUser currentUser] school] uid] isEqualToNumber:school.uid]) {
        cell.iconImageView.hidden = NO;
        _selectedCell = cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NMListTableViewCell *cell = (NMListTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.iconImageView.hidden = NO;
    if (_selectedCell) {
        cell.iconImageView.hidden = YES;
        _selectedCell = cell;
    }
}

@end
