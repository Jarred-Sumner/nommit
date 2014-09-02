//
//  NMFoodViewController.m
//  nommit
//
//  Created by Jarred Sumner on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodsViewController.h"
#import "NMFoodCell.h"
#import "NMCollectionViewSmallLayout.h"
#import "NMOrderFoodViewController.h"
#import "NMFoodItem.h"
#import "NMColors.h"
#import <APParallaxHeader/UIScrollView+APParallaxHeader.h>
#import <MGScrollView.h>
#import <CSStickyHeaderFlowLayout.h>
#import "NMCollectionHeaderView.h"

static const NSInteger NMFoodCount = 5;
static NSString *NMFoodCellIdentifier = @"FoodCellIdentifier";

@interface NMFoodsViewController ()<APParallaxViewDelegate>

@end

@implementation NMFoodsViewController

- (id)init {
    UICollectionViewFlowLayout *flowLayout = [[NMCollectionViewSmallLayout alloc] init];
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        [self setupCollectionView];
        [self.collectionView addParallaxWithImage:[UIImage imageNamed:@"Image"] andHeight:187];
        [self.collectionView.parallaxView setDelegate:self];
        [self initNavBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UICollectionView

- (void)setupCollectionView {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.55f];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:[NMFoodCell class] forCellWithReuseIdentifier:NMFoodCellIdentifier];
}

#pragma mark - UIColllectionViewDelegate



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NMFoodCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NMFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.clipsToBounds = YES;

    
    cell.itemImage = [UIImage imageNamed:@"PepperoniPizzaMini"];
    cell.itemName = @"Pepperoni Pizza";
    NSNumber *itemsLeft = [NSNumber numberWithInt:30];
    NSNumber *itemsTotal = [NSNumber numberWithInt:60];
    cell.itemsSoldAndTotal = [NSArray arrayWithObjects:itemsLeft, itemsTotal, nil];
    cell.progressBarView.progress = .5f;
    cell.itemPrice = 5;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"hi");
    // test code - DONT DELETE YET
    NMFoodItem *foodItem = [[NMFoodItem alloc] initWithTotalItems:70 withPrice:5 withName:@"Pepperoni Pizza" withDescription:@"A delicious slice of pizza filled with crispy pepperoni and scrumptuous cheese." withImage:[UIImage imageNamed:@"PepperoniPizza"] withItemsSold:23];
    NMOrderFoodViewController *orderFoodViewController = [[NMOrderFoodViewController alloc] initWithFoodItem:foodItem];
    [self.navigationController pushViewController:orderFoodViewController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(142, 200);
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

#pragma mark - nav bar

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(launchMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
}

@end
