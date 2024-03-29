//
//  NMSchoolsVewController.m
//  nommit
//
//  Created by Jarred Sumner on 12/16/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMListTableViewCell.h"
#import "NMSchoolsViewController.h"
#import "NMFooterRequestView.h"
#import "NMSupportViewController.h"


@interface NMSchoolsViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NMListTableViewCell *selectedCell;

@end

@implementation NMSchoolsViewController

static NSString *NMSchoolTableViewCellKey = @"NMSchoolTableViewCellKey";


- (id)initWithCompletionBlock:(NMCompletionBlock)completionBlock {
    self = [self initWithStyle:UITableViewStylePlain];
    _completionBlock = completionBlock;
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    self.view.backgroundColor = UIColorFromRGB(0xF8F8F8);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[NMListTableViewCell class] forCellReuseIdentifier:NMSchoolTableViewCellKey];
    self.tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    self.title = @"Choose School";
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:UIColorFromRGB(0x9C9C9C) forKey:NSForegroundColorAttributeName];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)] forKey:UITextAttributeTextShadowOffset];
    
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    [self setupRefreshing];
    [self setupFooter];
    
    return self;
}

- (void)setupFooter {
    NMFooterRequestView *view = [[NMFooterRequestView alloc] initWithText:@"Missing your school? Request it." withUnderlinedString:@"Request it." withFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
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


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refresh];
    self.navigationController.navigationBarHidden = NO;
    [[Mixpanel sharedInstance] track:@"Showed School Page"];
}

- (void)save {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:_selectedCell];
    if (indexPath) {
        __block NMSchoolsViewController *this = self;
        __block NSNumber *schoolID = [[self.fetchedResultsController objectAtIndexPath:indexPath] uid];
        
        [SVProgressHUD showWithStatus:@"Saving..." maskType:SVProgressHUDMaskTypeBlack];
        
        [[NMApi instance] PUT:[NSString stringWithFormat:@"users/%@", [[NMUser currentUser] facebookUID]] parameters:@{ @"school_id" : schoolID } completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
            
            [MagicalRecord saveUsingCurrentThreadContextWithBlock:^(NSManagedObjectContext *localContext) {
            
                NMUser *user = [NMUser MR_findFirstByAttribute:@"facebookUID" withValue:[NMSession userID] inContext:localContext];
                
                user.school = [NMSchool MR_findFirstByAttribute:@"uid" withValue:schoolID inContext:localContext];
                
                [NMFood MR_truncateAllInContext:localContext];
                [NMPlace MR_truncateAllInContext:localContext];
                [NMDeliveryPlace MR_truncateAllInContext:localContext];
                [NMOrder MR_truncateAllInContext:localContext];
            } completion:^(BOOL success, NSError *error) {
                [NMPlace setActivePlace:nil];
                [NMSession setSchoolID:[[response.result school] uid]];
                [SVProgressHUD showSuccessWithStatus:@"Saved!"];
                this.completionBlock();
            }];
            

        }];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"Please choose a school"];
    }
    
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
    if ([name length] > 40) {
        name = [NSString stringWithFormat:@"%@...", [name substringToIndex:40]];
    }
    
    cell.textLabel.text = name;
    cell.accessoryLabel.hidden = YES;
    
    NSNumber *currentSchoolID = [[[NMUser currentUser] school] uid];
    
    if ([currentSchoolID isEqualToNumber:school.uid]) {
        cell.iconImageView.hidden = NO;
        _selectedCell = cell;
    } else {
        cell.iconImageView.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NMListTableViewCell *cell = (NMListTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (_selectedCell) {
        _selectedCell.iconImageView.hidden = YES;
    }
    cell.iconImageView.hidden = NO;
    _selectedCell = cell;
}

@end
