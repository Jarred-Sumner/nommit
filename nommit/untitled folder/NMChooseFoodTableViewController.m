//
//  NMChooseFoodTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 1/11/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMChooseFoodTableViewController.h"
#import "NMDeliveryTableViewCell.h"

@interface NMChooseFoodTableViewController ()

@property (nonatomic, strong) NSMutableArray *selectedItemsArray;

@end

static NSString *NMDeliveryTableViewCellIdentifier = @"NMDeliveryTableViewCellKey";

@implementation NMChooseFoodTableViewController

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0xF3F1F1);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[NMDeliveryTableViewCell class] forCellReuseIdentifier:NMDeliveryTableViewCellIdentifier];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Choose a Food";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NMDeliveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMDeliveryTableViewCellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}

- (void)configureCell:(NMDeliveryTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.avatar.image = [UIImage imageNamed:@"PepperoniPizza2"];
    cell.name.text = @"Pepperoni Pizza";
    
    if([_selectedItemsArray containsObject:cell])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NMDeliveryTableViewCell *cell = (NMDeliveryTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.selectedOverlay.hidden == YES)
    {
        cell.selectedOverlay.hidden = NO;
        [_selectedItemsArray addObject:cell];
    }
    else
    {
        cell.selectedOverlay.hidden = YES;
        [_selectedItemsArray removeObject:cell];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
