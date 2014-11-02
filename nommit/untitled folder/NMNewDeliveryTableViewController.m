//
//  NMNewDeliveryTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMNewDeliveryTableViewController.h"
#import "NMDeliveryPlaceHeaderView.h"
#import "NMOrderTableViewCell.h"
#import "NMDeliveryPlaceFooter.h"


static NSTimeInterval NMOrderFetchInterval = 5;
static NSString *NMOrderTableViewCellIdentifier = @"NMOrderTableViewCellIdentifier";

@interface NMNewDeliveryTableViewController ()

@property (nonatomic) NSUInteger placeIndex;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NMDeliveryPlaceFooter *footerView;
@property (nonatomic, strong) UIButton *oldPlaceButton;

@end

@implementation NMNewDeliveryTableViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:self.tableView];
        
        _footerView = [[NMDeliveryPlaceFooter alloc] init];
        _footerView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_footerView.endShiftButton addTarget:self action:@selector(endShift) forControlEvents:UIControlEventTouchUpInside];
        [_footerView.hereButton addTarget:self action:@selector(imHere) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_footerView];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_footerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerView]|" options:(NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight) metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView, _footerView)]];
        
        
        [self.tableView registerClass:[NMOrderTableViewCell class] forCellReuseIdentifier:NMOrderTableViewCellIdentifier];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // [self.fetchedResultsController performFetch:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Current Orders";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : UIColorFromRGB(0x319396)};
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NMDeliveryPlaceHeaderView *view = [[NMDeliveryPlaceHeaderView alloc] initWithFrame:CGRectMake(0, 0, 273, 60)];
    view.backgroundColor = UIColorFromRGB(0xB00000);
    view.placeName.text = @"Mudge";
    view.placeNumber.text = [NSString stringWithFormat:@"%d", section];
    [view.arrivalButton addTarget:self action:@selector(arrivedAtLocation:) forControlEvents:UIControlEventTouchUpInside];
    [view setUrgency:NMDeliveryUrgencyHigh];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NMOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NMOrderTableViewCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(NMOrderTableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {
//    NMOrder *order = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = @"Lucy Guo";
    cell.orderName.text = @"1 - Chocolate Chip Cookies";
    cell.profileAvatar.profileID = @"633454537";
    
    [cell.callButton addTarget:self action:@selector(callUser:) forControlEvents:UIControlEventTouchUpInside];
    [cell.doneButton addTarget:self action:@selector(orderComplete:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Order-specific actions

- (void)callUser:(id)sender
{
    CGPoint buttonOriginInTableView = [sender convertPoint:CGPointZero toView:self.tableView];
    
    NSString *phNo = @"9255968005";
    NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phNo]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    } else
    {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Phone call errored. Try Again." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [calert show];
    }
}

#pragma mark - Header function

- (void)arrivedAtLocation:(id)button {
    UIButton *currentbutton = (UIButton *)button;
    if (_oldPlaceButton) {
        _oldPlaceButton.hidden = NO;
    }
    _oldPlaceButton = currentbutton;
    currentbutton.hidden = YES;
}

@end
