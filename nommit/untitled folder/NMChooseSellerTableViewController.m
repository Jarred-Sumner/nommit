//
//  NMChooseSellerTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 1/11/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMChooseSellerTableViewController.h"
#import "NMChooseTableViewCell.h"
#import "NMChooseFoodTableViewController.h"

@interface NMChooseSellerTableViewController ()

@property (nonatomic, strong) NSArray *sellers;

@end

@implementation NMChooseSellerTableViewController

static NSString *NMDeliveryTableViewCellKey = @"NMDeliveryTableViewCell";

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0xF3F1F1);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[NMChooseTableViewCell class] forCellReuseIdentifier:NMDeliveryTableViewCellKey];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Choose a Seller";

    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self refresh];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _sellers.count;
    } else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMDeliveryTableViewCellKey];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;

}

- (void)configureCell:(NMChooseTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NMSellerApiModel *seller = (NMSellerApiModel*)_sellers[indexPath.row];

    [cell.avatar setImageWithURL:[NSURL URLWithString:seller.logoURL] placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
    cell.name.text = seller.name;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NMSellerApiModel *seller = _sellers[indexPath.row];
    
    NMChooseFoodTableViewController *chooseFoodVC = [[NMChooseFoodTableViewController alloc] initWithSeller:seller];
    [self.navigationController pushViewController:chooseFoodVC animated:YES];
}

#pragma mark - Refresh

- (void)refresh {
    [self.refreshControl beginRefreshing];
    
    __block NMChooseSellerTableViewController *this = self;
    [[NMApi instance] GET:@"sellers" parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        this.sellers = [MTLJSONAdapter modelsOfClass:[NMSellerApiModel class] fromJSONArray:response.result error:&error];
        
        [UIView transitionWithView: self.tableView
                          duration: 0.15f
                           options: UIViewAnimationOptionTransitionCrossDissolve
                        animations: ^(void) {
                            [this.tableView reloadData];
                        } completion:NULL];
        [this.refreshControl endRefreshing];
    }];
}

@end
