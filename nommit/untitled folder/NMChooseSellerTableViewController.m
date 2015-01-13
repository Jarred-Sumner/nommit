//
//  NMChooseSellerTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 1/11/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMChooseSellerTableViewController.h"
#import "NMDeliveryTableViewCell.h"
#import "NMChooseFoodTableViewController.h"

@interface NMChooseSellerTableViewController ()

@end

@implementation NMChooseSellerTableViewController

static NSString *NMDeliveryTableViewCellKey = @"NMDeliveryTableViewCell";

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0xF3F1F1);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[NMDeliveryTableViewCell class] forCellReuseIdentifier:NMDeliveryTableViewCellKey];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Choose a Seller";
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
}

- (void)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMDeliveryTableViewCellKey];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;

}

- (void)configureCell:(NMDeliveryTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.avatar.image = [UIImage imageNamed:@"PepperoniPizza2"];
    cell.name.text = @"Delta Delta Delta";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NMChooseFoodTableViewController *chooseFoodVC = [[NMChooseFoodTableViewController alloc] init];
    [self.navigationController pushViewController:chooseFoodVC animated:YES];
}

@end
