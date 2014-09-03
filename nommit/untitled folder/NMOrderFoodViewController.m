//
//  NMOrderFoodViewController.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodViewController.h"

#import "NMOrderFoodInfoCell.h"
#import "NMOrderFoodProgressCell.h"
#import "NMOrderFoodDeliveryDetailsCell.h"
#import "NMOrderFoodOrderButtonCell.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>

const NSInteger NMInfoSection = 0;
const NSInteger NMProgressSection = 1;
const NSInteger NMOrderDeliveryDetailsSection = 2;
const NSInteger NMOrderButtonSection = 3;

static NSString *NMOrderFoodInfoIdentifier = @"NMOrderFoodInfoCell";
static NSString *NMOrderFoodProgressIdentifier = @"NMOrderFoodProgressCell";
static NSString *NMOrderFoodDeliveryIdentifier = @"NMOrderFoodDeliveryDetailsCell";
static NSString *NMOrderFoodButtonIdentifier = @"NMOrderFoodOrderButtonCell";

@interface NMOrderFoodViewController ()<APParallaxViewDelegate, NMOrderFoodProgressCell>

@property (nonatomic, strong) NMFoodItem *foodItem;

@end

@implementation NMOrderFoodViewController

- (instancetype)initWithFoodItem:(NMFoodItem *)foodItem {
    self = [super initWithStyle:UITableViewStylePlain];
    _foodItem = foodItem;
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[NMOrderFoodInfoCell class] forCellReuseIdentifier:NMOrderFoodInfoIdentifier];
    [self.tableView registerClass:[NMOrderFoodProgressCell class] forCellReuseIdentifier:NMOrderFoodProgressIdentifier];
    [self.tableView registerClass:[NMOrderFoodDeliveryDetailsCell class] forCellReuseIdentifier:NMOrderFoodDeliveryIdentifier];
    [self.tableView registerClass:[NMOrderFoodOrderButtonCell class] forCellReuseIdentifier:NMOrderFoodButtonIdentifier];
    
    [self.tableView addParallaxWithImage:foodItem.headerImage andHeight:150];
    [self.tableView.parallaxView setDelegate:self];
    
    [self initNavBar];
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMInfoSection) {
        return 110;
    } else if (indexPath.section == NMProgressSection) {
        return 115;
    } else if (indexPath.section == NMOrderDeliveryDetailsSection) {
        return 50;
    } else if (indexPath.section == NMOrderButtonSection) {
        return 66;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == NMInfoSection) {
        return 1;
    } else if (section == NMProgressSection) {
        return 1;
    } else if (section == NMOrderDeliveryDetailsSection) {
        return 2;
    } else if (section == NMOrderButtonSection) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == NMInfoSection) {
        NMOrderFoodInfoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodInfoIdentifier];
        cell.nameLabel.text = _foodItem.itemName;
        cell.descriptionLabel.text = _foodItem.description;
        cell.priceLabel.text = [NSString stringWithFormat:@"$%d", _foodItem.price];
        
        return cell;
    } else if (indexPath.section == NMProgressSection) {
        NMOrderFoodProgressCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodProgressIdentifier];
        cell.delegate = self;
        cell.progressBarView.progress = 0.5f;
        NSNumber *left = [NSNumber numberWithInt:_foodItem.itemsTotal - _foodItem.itemsSold];
        NSNumber *total = [NSNumber numberWithInt:_foodItem.itemsTotal];
        cell.leftSold = @[left, total];
        
        return cell;
    } else if (indexPath.section == NMOrderDeliveryDetailsSection) {
        NMOrderFoodDeliveryDetailsCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodDeliveryIdentifier];
        
        switch (indexPath.row) {
            case 0:
                cell.textField.placeholder = @"Address";
                break;
            case 1:
                cell.textField.placeholder = @"Room #";
                break;
            default:
                break;
        }
        return cell;
    
    } else if (indexPath.section == NMOrderButtonSection) {
        NMOrderFoodOrderButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier:NMOrderFoodButtonIdentifier];
        
        return cell;
        
    }
    return nil;
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

#pragma mark - Navigation Bar Customization

- (void)initNavBar
{
//    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
//                                                            style:UIBarButtonItemStylePlain
//                                                           target:self
//                                                           action:@selector(launchMenu)];
//    
//    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
//    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
}

#pragma mark - digit input delegates

/////////// recating on demo events ///////////
-(void)didBeginEditing:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"did begin editing %i",input.value);
}

-(void)didEndEditing:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"did end editing %i",input.value);
}

-(void)textDidChange:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"text did change %i",input.value);
}

-(void)valueChanged:(id)sender
{
    CHDigitInput *input = (CHDigitInput *)sender;
    NSLog(@"value changed %i",input.value);
}

@end
