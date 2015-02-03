//
//  NMCreateFoodTableViewController.m
//  nommit
//
//  Created by Lucy Guo on 2/2/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMCreateFoodTableViewController.h"

#import "NMOrderFoodInfoCell.h"
#import "NMOrderFoodProgressCell.h"
#import "NMOrderFoodConfirmAddressCell.h"
#import "NMOrderFoodOrderButtonCell.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import "NMAddressSearchViewController.h"
#import "NMNavigationController.h"
#import "NMDeliveryTableViewController.h"
#import "NMPromoCodeTableViewCell.h"
#import "NMOrderFoodDescriptionTableViewCell.h"
#import "NMDeliveryTableViewController.h"
#import "UIScrollView+NMParallaxHeader.h"
#import <SIAlertView/SIAlertView.h>
#import "NMApi.h"
#import "DBCameraViewController.h"
#import "DBCameraContainerViewController.h"
#import "DBCameraSegueViewController.h"



const NSInteger NMCreateInfoSection = 0;
const NSInteger NMCreateDescriptionSecton = 1;
const NSInteger NMCreateProgressSection = 2;
const NSInteger NMCreateOrderFoodConfirmationSection = 4;
const NSInteger NMCreateOrderButtonSection = 5;
const NSInteger NMCreateOrderPromoSection = 3;

static NSString *NMCreateOrderFoodInfoIdentifier = @"NMOrderFoodInfoCell";
static NSString *NMCreateOrderFoodDescriptionIdentifier = @"NMOrderFoodDescriptionCell";
static NSString *NMCreateOrderFoodProgressIdentifier = @"NMOrderFoodProgressCell";
static NSString *NMCreateOrderFoodConfirmAddressCellIdentifier = @"NMOrderFoodConfirmAddressCell";
static NSString *NMCreateOrderFoodButtonIdentifier = @"NMOrderFoodOrderButtonCell";
static NSString *NMCreateOrderFoodPromoIdentifier = @"NMOrderFoodPromoCell";

@interface NMCreateFoodTableViewController ()<APParallaxViewDelegate, DBCameraCollectionControllerDelegate>


// @property (nonatomic, strong) NMOrderFoodInfoCell *infoCell;
@property (nonatomic, strong) NMOrderFoodBasicInfoTableViewCell *infoCell;
@property (nonatomic, strong) NMOrderFoodDescriptionTableViewCell *descriptionCell;
@property (nonatomic, strong) NMOrderFoodProgressCell *progressCell;
@property (nonatomic, strong) NMOrderFoodConfirmAddressCell *confirmAddressCell;
@property (nonatomic, strong) NMPromoCodeTableViewCell *promoCell;


@end

@implementation NMCreateFoodTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        // [self.tableView registerClass:[NMOrderFoodInfoCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
        [self.tableView registerClass:[NMOrderFoodBasicInfoTableViewCell class] forCellReuseIdentifier:NMCreateOrderFoodInfoIdentifier];
        [self.tableView registerClass:[NMOrderFoodDescriptionTableViewCell class] forCellReuseIdentifier:NMCreateOrderFoodDescriptionIdentifier];
        [self.tableView registerClass:[NMOrderFoodProgressCell class] forCellReuseIdentifier:NMCreateOrderFoodProgressIdentifier];
        [self.tableView registerClass:[NMOrderFoodConfirmAddressCell class] forCellReuseIdentifier:NMCreateOrderFoodConfirmAddressCellIdentifier];
        [self.tableView registerClass:[NMOrderFoodOrderButtonCell class] forCellReuseIdentifier:NMCreateOrderFoodButtonIdentifier];
        [self.tableView registerClass:[NMPromoCodeTableViewCell class] forCellReuseIdentifier:NMCreateOrderFoodPromoIdentifier];
        
        [self.tableView addParallaxWithImage:nil andHeight:150];
        [self.tableView.parallaxView setDelegate:self];
        [self.tableView addBlackOverlayToParallaxView];
        
        [self.tableView.parallaxView.imageView setImage:[UIImage imageNamed:@"LoadingImage"]];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setHeader)];
        
        [self addTapGestureRecognizer:singleTap onView:self.tableView.parallaxView];        
        [self.tableView addTextFieldToParallaxView];
        
        
        return self;

    }
    return self;
}

- (void)addTapGestureRecognizer:(UITapGestureRecognizer *)gesture onView:(UIView *)view
{
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    gesture.delegate = self;
    [view addGestureRecognizer:gesture];
    view.userInteractionEnabled = YES;
}

- (void)setHeader {
    NSLog(@"Bring up camera or other stuff");
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setUseCameraSegue:YES];
    [container setCameraViewController:cameraController];
    [cameraController setCameraSegueConfigureBlock:^( DBCameraSegueViewController *segue ) {
        segue.cropMode = YES;
        segue.cropRect = (CGRect){ 0, 0, 320.18, 187 };
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:container];
    [nav setNavigationBarHidden:YES];
    [container setFullScreenMode];
    [self presentViewController:nav animated:YES completion:nil];
    
}

//Use your captured image
#pragma mark - DBCameraViewControllerDelegate

- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata
{
    [self.tableView.parallaxView.imageView setImage:image];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
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

// The pan gesture recognizer messes with iOS 7 swipe to go back.
// So, we disable the menu for this page.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"Create Food";
    
    [(NMNavigationController*)self.navigationController setDisabledMenu:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [(NMNavigationController*)self.navigationController setDisabledMenu:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // make total 354
    if (indexPath.section == NMCreateInfoSection) {
        return 68;
    } else if (indexPath.section == NMCreateDescriptionSecton) {
        return 83;
    } else if (indexPath.section == NMCreateProgressSection) {
        return 69;
    } else if (indexPath.section == NMCreateOrderFoodConfirmationSection || indexPath.section == NMCreateOrderPromoSection) {
        return 42.5;
    } else if (indexPath.section == NMCreateOrderButtonSection) {
        return 49;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == NMCreateInfoSection) {
        return 1;
    } else if (section == NMCreateDescriptionSecton) {
        return 1;
    } else if (section == NMCreateProgressSection) {
        return 1;
    } else if (section == NMCreateOrderFoodConfirmationSection) {
        return 1;
    } else if (section == NMCreateOrderButtonSection) {
        return 1;
    } else if (section == NMCreateOrderPromoSection) {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMCreateInfoSection) {
        _infoCell = [self.tableView dequeueReusableCellWithIdentifier:NMCreateOrderFoodInfoIdentifier];
        
        [_infoCell.avatar setImageWithURL:[UIImage imageNamed:@"ChefAvatar"]];
        _infoCell.nameLabel.text = @"Name";
        _infoCell.quantityInput.value = 1;
        _infoCell.priceLabel.text = @"0.00";
        return _infoCell;
    } else if (indexPath.section == NMCreateDescriptionSecton) {
        _descriptionCell = [self.tableView dequeueReusableCellWithIdentifier:NMCreateOrderFoodDescriptionIdentifier];
        _descriptionCell.descriptionLabel.text = @"Enter description here";
        return _descriptionCell;
    } else if (indexPath.section == NMCreateProgressSection) {
        _progressCell = [self.tableView dequeueReusableCellWithIdentifier:NMCreateOrderFoodProgressIdentifier];
        
        _progressCell.progressBarView.progress = .5f;
        
        _progressCell.progressLabel.text = @"100/100 left";
        _progressCell.progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressCell.rateVw.rating = 4.5f;
        
        return _progressCell;
    } else if (indexPath.section == NMCreateOrderFoodConfirmationSection) {
        _confirmAddressCell = [self.tableView dequeueReusableCellWithIdentifier:NMCreateOrderFoodConfirmAddressCellIdentifier];
        return _confirmAddressCell;
    } else if (indexPath.section == NMCreateOrderPromoSection) {
        _promoCell = [self.tableView dequeueReusableCellWithIdentifier:NMCreateOrderFoodPromoIdentifier];
        return _promoCell;
    } else if (indexPath.section == NMCreateOrderButtonSection) {
        NMOrderFoodOrderButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMCreateOrderFoodButtonIdentifier];
        [cell.orderButton addTarget:self action:@selector(orderFoodButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    } else return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
