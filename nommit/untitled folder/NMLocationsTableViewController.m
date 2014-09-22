//
//  NMLocationsTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLocationsTableViewController.h"

@interface NMLocationsTableViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *items;

@end

@implementation NMLocationsTableViewController

static NSString * CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Table View";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchBar;
    
    self.items = @[@"Mudge", @"Stever", @"Morewood", @"Donner"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
