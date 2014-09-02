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
    UICollectionViewFlowLayout *cssStickHeaderLayout = [[CSStickyHeaderFlowLayout alloc] init];
    self = [super initWithCollectionViewLayout:cssStickHeaderLayout];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        [self setupCollectionView];
        [self.collectionView addParallaxWithImage:[UIImage imageNamed:@"Image1"] andHeight:160];
        [self.collectionView.parallaxView setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CSStickyHeaderFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
//    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
//        layout.parallaxHeaderReferenceSize = CGSizeMake(320, 200);
//    }
//    
//    [self.collectionView registerClass:[NMCollectionHeaderView class] forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withReuseIdentifier:@"header"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UICollectionView

- (void)setupCollectionView {
    
//    UICollectionViewFlowLayout *flowLayout = [[NMCollectionViewSmallLayout alloc] init];
//    
//    UICollectionViewFlowLayout *cssStickHeaderLayout = [[CSStickyHeaderFlowLayout alloc] init];
//    
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:cssStickHeaderLayout];
    
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.55f];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self.collectionView registerClass:[NMFoodCell class] forCellWithReuseIdentifier:NMFoodCellIdentifier];
    
//    NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_collectionView(200)]|" options:0 metrics:nil views:views]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:views]];
}

#pragma mark - UIColllectionViewDelegate



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NMFoodCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NMFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 4;
    cell.clipsToBounds = YES;
    cell.layer.borderColor = [UIColorFromRGB(0xE9E9E9) CGColor];
    cell.layer.borderWidth = 1.0f;
    
    cell.itemImage = [UIImage imageNamed:@"PepperoniPizza"];
    
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
    // return self.collectionView.frame.size;
    return CGSizeMake(142, 187);
}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    // Check the kind if it's CSStickyHeaderParallaxHeader
//    if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
//        
//        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                            withReuseIdentifier:@"header"
//                                                                                   forIndexPath:indexPath];
//        
//        return cell;
//        
//    } else if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        // Your code to configure your section header...
//    } else {
//        // other custom supplementary views
//    }
//    return nil;
//}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview before its frame changes
    NSLog(@"parallaxView:willChangeFrame: %@", NSStringFromCGRect(frame));
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    // Do whatever you need to do to the parallaxView or your subview after its frame changed
    NSLog(@"parallaxView:didChangeFrame: %@", NSStringFromCGRect(frame));
}

@end
