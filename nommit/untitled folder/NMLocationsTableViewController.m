//
//  NMLocationsTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLocationsTableViewController.h"
#import "NMLocationTableViewCell.h"


@interface NMLocationsTableViewController ()<UISearchBarDelegate>

@property (nonatomic, strong) NSArray *items;

@end

@implementation NMLocationsTableViewController

static NSString * CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Table View";
    
    [self.tableView registerClass:[NMLocationTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
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
    NMLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[NMLocationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    NMLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:16.0];
    cell.textLabel.text = self.items[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate setSelectedAddress:[self.items objectAtIndex:indexPath.row]];
}

@end
