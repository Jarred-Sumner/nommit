//
//  NMPickPlacesTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPickPlacesTableViewController.h"
#import "NMPickPlaceTableViewCell.h"

@interface NMPickPlacesTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation NMPickPlacesTableViewController

static NSString *NMPickPlaceCellIdentifier = @"NMPickPlaceCell";

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    [self.tableView registerClass:[NMPickPlaceTableViewCell class] forCellReuseIdentifier:NMPickPlaceCellIdentifier];
    [self.fetchedResultsController performFetch:nil];
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.fetchedResultsController performFetch:nil];
    self.title = @"Pick Delivery Places";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleDone target:self action:@selector(done:)];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fetchedResultsController performFetch:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NMPickPlaceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMPickPlaceCellIdentifier];

    cell.textLabel.text = @"Mudge";
    cell.textLabel.textColor = UIColorFromRGB(0x757575);
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    (cell.accessoryType == UITableViewCellAccessoryNone) ? (cell.accessoryType = UITableViewCellAccessoryCheckmark) : (cell.accessoryType = UITableViewCellAccessoryNone) ;
}


@end
