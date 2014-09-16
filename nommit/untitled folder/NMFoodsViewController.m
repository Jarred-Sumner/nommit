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
#import "NMCollectionHeaderView.h"
#import <REFrostedViewController.h>
#import "NMMenuNavigationController.h"
#import "NMRibbonCell.h"

static const NSInteger NMFoodCount = 5;
static const NSInteger headerHeight = 187;
static NSString *NMFoodCellIdentifier = @"FoodCellIdentifier";
static NSString *NMRibbonCellIdentifier = @"RibbonCellIdentifier";

@interface NMFoodsViewController ()<APParallaxViewDelegate>

@property (nonatomic, strong) NSArray *foods;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, assign) NSInteger slide;
@property (nonatomic, getter=isFullscreen) BOOL fullscreen;
@property (nonatomic, getter=isTransitioning) BOOL transitioning;


@end

@implementation NMFoodsViewController

- (id)init {
    UICollectionViewFlowLayout *flowLayout = [[NMCollectionViewSmallLayout alloc] init];
    self = [super initWithCollectionViewLayout:flowLayout];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        [self setupCollectionView];
        [self.collectionView addParallaxWithImage:[UIImage imageNamed:@"Image"] andHeight:headerHeight];
        [self.collectionView.parallaxView setDelegate:self];
        self.collectionView.contentOffset = CGPointMake(0, 0);
        [self initNavBar];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _galleryImages = @[@"Image", @"Image1", @"Image2", @"Image3", @"Image4"];
    _slide = 0;
    
    // First Load
    [self changeSlide];
    
    // Loop gallery - fix loop: http://bynomial.com/blog/?p=67
    NSTimer *timer = [NSTimer timerWithTimeInterval:3.5f target:self selector:@selector(changeSlide) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - UICollectionView

- (void)setupCollectionView {
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.55f];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:[NMFoodCell class] forCellWithReuseIdentifier:NMFoodCellIdentifier];
    [self.collectionView registerClass:[NMRibbonCell class] forCellWithReuseIdentifier:NMRibbonCellIdentifier];
    [self setupDataSource];
}

#pragma mark - UIColllectionViewDelegate



#pragma mark - UICollectionViewDataSource

- (void)setupDataSource {
    self.foods = [NMFood activeFoods];
    _refreshControl = [[UIRefreshControl alloc] init];
    [_refreshControl addTarget:self action:@selector(refreshFoods) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:_refreshControl];
    
    [self refreshFoods];
}

- (void)refreshFoods {
    __weak NMFoodsViewController *this = self;
    [self.refreshControl beginRefreshing];
    
    [[NMApi instance] GET:@"foods" parameters:@{ @"access_token" : [NMSession accessToken] } completion:^(OVCResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error Updating: %@", error);
        } else {
            this.foods = [NMFoodApiModel foodsForModels:response.result];
        }
        [this.refreshControl endRefreshing];
        [this.collectionView reloadData];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foods.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NMRibbonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NMRibbonCellIdentifier forIndexPath:indexPath];
//        UIImageView *banner = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 289.5/2, headerHeight - 35/2, 289.5, 35)];
//        banner.image = [UIImage imageNamed:@"HomeRibbon"];
//        [cell addSubview:banner];
        return cell;
    } else {
        NMFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
        cell.food = self.foods[indexPath.row - 1];;
        return cell;
    }

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"hi");
    // test code - DONT DELETE YET
    NMFoodItem *foodItem = [[NMFoodItem alloc] initWithTotalItems:70 withPrice:5 withName:@"Pepperoni Pizza" withDescription:@"A delicious slice of pizza filled with crispy pepperoni and scrumptuous cheese." withImage:[UIImage imageNamed:@"PepperoniPizza"] withItemsSold:23];
    NMOrderFoodViewController *orderFoodViewController = [[NMOrderFoodViewController alloc] initWithFoodItem:foodItem];
    [self.navigationController pushViewController:orderFoodViewController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) return CGSizeMake(289.5, 35);
    return CGSizeMake(142, 200);
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
//    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
//    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

#pragma mark - nav bar

- (void)initNavBar
{
    UIBarButtonItem *lbb = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"HamburgerIcon"]
                                                            style:UIBarButtonItemStylePlain
                                                           target:(NMMenuNavigationController *)self.navigationController
                                                           action:@selector(showMenu)];
    
    lbb.tintColor = UIColorFromRGB(0xC3C3C3);
    self.navigationItem.leftBarButtonItem = lbb;
    
    // Logo in the center of navigation bar
    UIView *logoView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 88, 21)];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavLogo"]];
    titleImageView.frame = CGRectMake(0, 0, titleImageView.frame.size.width, titleImageView.frame.size.height);
    [logoView addSubview:titleImageView];
    self.navigationItem.titleView = logoView;
    
}

#pragma mark - Change slider
- (void)changeSlide
{
    if (_fullscreen == NO && _transitioning == NO) {
        if(_slide > _galleryImages.count-1) _slide = 0;
        
        UIImage *toImage = [UIImage imageNamed:_galleryImages[_slide]];
        [UIView transitionWithView:self.collectionView.parallaxView
                          duration:0.6f
                           options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationCurveEaseInOut
                        animations:^{
                            self.collectionView.parallaxView.imageView.image = toImage;
                        } completion:nil];
        _slide++;
    }
}

-(BOOL)prefersStatusBarHidden { return NO; }

@end
