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

static const NSInteger NMFoodCount = 2;
static NSString *NMFoodCellIdentifier = @"FoodCellIdentifier";

@interface NMFoodsViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSArray *galleryImages;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *bodyLabel;

@property NSInteger slide;

@end

@implementation NMFoodsViewController

- (void)loadView
{
    [super loadView];
    self.view.clipsToBounds = YES;
    self.view.layer.cornerRadius = 4;
    
    [self setupBackgroundImageView];
    [self setupCollectionView];
    [self setupLabels];
}

#pragma mark - backgroundImageView

- (void)setupBackgroundImageView {
    
    // Gallery Images
    _galleryImages = @[@"Image", @"Image1", @"Image2", @"Image3", @"Image4"];
    _slide = 0;
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    
    // Gradient to top image
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _backgroundImageView.bounds;
    gradient.colors = @[(id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4] CGColor],
                        (id)[[UIColor colorWithWhite:0 alpha:0] CGColor]];
    [_backgroundImageView.layer insertSublayer:gradient atIndex:0];
    
    // Content perfect pixel
    UIView *perfectPixelContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backgroundImageView.bounds), 1)];
    perfectPixelContent.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    [_backgroundImageView addSubview:perfectPixelContent];
    
    // First Load
    [self changeSlide];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:5.0f target:self selector:@selector(changeSlide) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    [self.view addSubview:_backgroundImageView];
}

- (void)changeSlide
{
    if (_slide > _galleryImages.count - 1) _slide = 0;
    
    UIImage *toImage = [UIImage imageNamed:_galleryImages[_slide]];
    [UIView transitionWithView:self.view
                      duration:0.6f
                       options:UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationCurveEaseInOut
                    animations:^{
                        _backgroundImageView.image = toImage;
                    } completion:nil];
    _slide++;
    //    }
}

#pragma mark - Labels

- (void)setupLabels {
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_titleLabel setClipsToBounds:NO];
    [_titleLabel.layer setShadowOffset:CGSizeMake(0, 0)];
    [_titleLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [_titleLabel.layer setShadowRadius:1.0];
    [_titleLabel.layer setShadowOpacity:0.6];
    
    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.backgroundColor = [UIColor clearColor];
    _subtitleLabel.textColor = [UIColor whiteColor];
    _subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_subtitleLabel setClipsToBounds:NO];
    [_subtitleLabel.layer setShadowOffset:CGSizeMake(0, 0)];
    [_subtitleLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [_subtitleLabel.layer setShadowRadius:1.0];
    [_subtitleLabel.layer setShadowOpacity:0.6];
    
    _bodyLabel = [[UILabel alloc] init];
    _bodyLabel.backgroundColor = [UIColor clearColor];
    _bodyLabel.textColor = [UIColor whiteColor];
    _bodyLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    _bodyLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _bodyLabel.numberOfLines = 0;
    _bodyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_bodyLabel setClipsToBounds:NO];
    [_bodyLabel.layer setShadowOffset:CGSizeMake(0, 0)];
    [_bodyLabel.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [_bodyLabel.layer setShadowRadius:1.0];
    [_bodyLabel.layer setShadowOpacity:0.6];
    
    _titleLabel.text = @"Pepperoni Pizza";
    _subtitleLabel.text = @"Round Table";
    _bodyLabel.text = @"Delicious pizza cooked fresh. Receive it in under 10 minutes.";
    
    [self.view addSubview:_titleLabel];
    [self.view addSubview:_subtitleLabel];
    [self.view addSubview:_bodyLabel];

    NSDictionary *views = NSDictionaryOfVariableBindings(_titleLabel, _subtitleLabel, _bodyLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-75-[_titleLabel]-5-[_subtitleLabel]-8-[_bodyLabel]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel]-30-|"options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_subtitleLabel]-30-|"options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_bodyLabel]-30-|"options:0 metrics:nil views:views]];
    
}

#pragma mark - UICollectionView

- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[NMCollectionViewSmallLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.2f];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = YES;

    [_collectionView registerClass:[NMFoodCell class] forCellWithReuseIdentifier:NMFoodCellIdentifier];
    [self.view addSubview:_collectionView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_collectionView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_collectionView(200)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:views]];
}

#pragma mark - UIColllectionViewDelegate



#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NMFoodCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NMFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NMFoodCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.layer.cornerRadius = 4;
    cell.clipsToBounds = YES;
    
    cell.itemImage = [UIImage imageNamed:@"Image1"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"hi");
    NMFoodItem *foodItem = [[NMFoodItem alloc] initWithTotalItems:70 withPrice:5 withName:@"Pepperoni Pizza" withDescription:@"All the delicious and cheesines" withImage:[UIImage imageNamed:@"Image1"]];
    NMOrderFoodViewController *orderFoodViewController = [[NMOrderFoodViewController alloc] initWithNibName:nil bundle:nil withFoodItem:foodItem];
    [self.navigationController pushViewController:orderFoodViewController animated:YES];
}

@end
