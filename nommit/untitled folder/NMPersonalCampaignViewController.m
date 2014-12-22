////
////  NMPersonalCampaignViewController.m
////  nommit
////
////  Created by Lucy Guo on 9/11/14.
////  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
////
//
//#import "NMPersonalCampaignViewController.h"
//#import "NMCampaignVisibilityTableViewCell.h"
//#import "NMFoodsViewController.h"
//#import "NMMenuNavigationController.h"
//#import "TYMProgressBarView.h"
//
//static NSString *NMCampaignVisibilityIdentifier = @"NMCampaignVisibilityTableViewCell";
//
//@interface NMPersonalCampaignViewController () {
//    NMCampaignVisibilityTableViewCell *cvtvc;
//}
//
//@end
//
//@implementation NMPersonalCampaignViewController
//
//- (instancetype)initWithFood:(NMFood *)food {
//    self = [super initWithFood:food];
//    [self.tableView registerClass:[NMCampaignVisibilityTableViewCell class] forCellReuseIdentifier:NMCampaignVisibilityIdentifier];
//    
//    // setup cancel button
//    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
//                                                            style:UIBarButtonItemStylePlain
//                                                           target:(NMMenuNavigationController *)self.navigationController
//                                                           action:@selector(showMenu)];
//    
//    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
//    self.navigationItem.leftBarButtonItem = lbb;
//    
//    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonSystemItemEdit target:self action:@selector(delete:)];
//    deleteButton.enabled = YES;
//    self.navigationItem.rightBarButtonItem = deleteButton;
//    
//    [self setupProgressBar];
//    
//    return self;
//}
//
//- (void)setupProgressBar
//{
//    // Add it to your view
//    
//}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 4;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 2) {
//        return 100;
//    }
//    if (indexPath.section == 3) {
//        return 74;
//    } else {
//        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // TEST CREATE CM CAMPAIGN
//    if (indexPath.section == 3) {
//        cvtvc = [[NMCampaignVisibilityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NMCampaignVisibilityIdentifier];
//        cvtvc.campaignSwitch.on = [[self.foodItem isOn] boolValue];
//        return cvtvc;
//    } else {
//        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
//    }
//    
//    return nil;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//- (void)cancel:(id)sender {
////    [self.foodItem setObject:[NSNumber numberWithBool:cvtvc.campaignSwitch.on] forKey:@"isOn"];
////    [self.foodItem saveInBackground];
////    NMFoodsViewController *mainVC = [[NMFoodsViewController alloc] init];
////    [self.navigationController pushViewController:mainVC animated:YES];
//}
//
//- (void)delete:(id)sender {
//    // TODO : DELETE
////    [self.foodItem deleteInBackground];
////    NMFoodsViewController *mainVC = [[NMFoodsViewController alloc] init];
////    [self.navigationController pushViewController:mainVC animated:YES];
//}
//
//@end
