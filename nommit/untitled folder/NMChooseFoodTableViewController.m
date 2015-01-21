//
//  NMChooseFoodTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 1/11/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMChooseFoodTableViewController.h"
#import "NMChooseTableViewCell.h"
#import "NMDeliveryPlacesTableViewController.h"

@interface NMChooseFoodTableViewController ()

@property (nonatomic, strong) NMSellerApiModel *seller;
@property (nonatomic, strong) NSArray *foods;
@property (nonatomic, strong) NSMutableSet *selectedFoods;

@end

static NSString *NMDeliveryTableViewCellIdentifier = @"NMDeliveryTableViewCellKey";

@implementation NMChooseFoodTableViewController

- (id)initWithSeller:(NMSellerApiModel *)seller {
    self = [self init];
    _seller = seller;
    _selectedFoods = [[NSMutableSet alloc] init];
    return self;
}

- (id)init {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.view.backgroundColor = UIColorFromRGB(0xF3F1F1);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[NMChooseTableViewCell class] forCellReuseIdentifier:NMDeliveryTableViewCellIdentifier];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Choose a Food";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self refresh];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(choosePlaces)];
}

- (void)choosePlaces {
    if (_selectedFoods.count > 0) {
        NMDeliveryPlacesTableViewController *vc = [[NMDeliveryPlacesTableViewController alloc] initWithFoods:_selectedFoods.allObjects seller:_seller];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showErrorWithStatus:@"Please choose a food to deliver"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _foods.count;
    } else return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMDeliveryTableViewCellIdentifier];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
    
}

- (void)configureCell:(NMChooseTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NMFoodApiModel *food = [self.foods objectAtIndex:indexPath.row];
    [cell.avatar setImageWithURL:[NSURL URLWithString:food.thumbnailImageURL] placeholderImage:nil];
    cell.name.text = food.title;
    cell.tag = food.uid.integerValue;
    
    if ([_selectedFoods member:food.uid]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NMChooseTableViewCell *cell = (NMChooseTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell.selectedOverlay.hidden == YES) {
        cell.selectedOverlay.hidden = NO;
        [_selectedFoods addObject:@(cell.tag)];
    } else {
        cell.selectedOverlay.hidden = YES;
        [_selectedFoods removeObject:@(cell.tag)];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Refresh

- (void)refresh {
    [self.refreshControl beginRefreshing];
    
    __block NMChooseFoodTableViewController *this = self;
    [[NMApi instance] GET:[NSString stringWithFormat:@"sellers/%@/foods", _seller.uid] parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        this.foods = [MTLJSONAdapter modelsOfClass:[NMFoodApiModel class] fromJSONArray:response.result error:nil];
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
