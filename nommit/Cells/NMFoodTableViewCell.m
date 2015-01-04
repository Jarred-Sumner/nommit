//
//  NMFoodTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMFoodTableViewCell.h"
#import "TYMProgressBarView.h"
#import "NMColors.h"
#import "NMNavigationController.h"
#import "NMFoodCellHeaderView.h"
#import "RateView.h"
#import  "MZTimerLabel.h"

@interface NMFoodTableViewCell()

@property (nonatomic, strong) UIImageView *foodImageView;
@property (nonatomic, strong) UIImageView *cellBG;
@property (nonatomic, strong) NMFoodCellHeaderView *headerView;
@property (nonatomic, strong) UILabel *soldLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sellerLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TYMProgressBarView *progressBarView;
@property (nonatomic, strong) UIImageView *sellerLogoImageView;
@property (nonatomic, strong) RateView *rateVw;

@property (nonatomic, strong) UILabel *startTimeLabel;
@property (nonatomic, strong) UIImageView *overlayView;


@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *startDate;

@end

@implementation NMFoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xF3F1F1);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupFoodImage];
        [self setupCellBG];
        
        [self setupSellerLogoImageView];
        [self setupFoodLabel];
        [self setupSellerLabel];
        [self setupPriceLabel];
        [self setupSoldLabel];
        [self setupProgressBar];
        [self setupRating];
        
        [self setupOverLay];
        [self setupFeaturedBadge];
        [self setupStartLabel];
    }
    return self;
}

- (void)setFood:(NMFood*)food {
    _featuredBadge.hidden = !food.featuredValue;
    
    [_sellerLogoImageView setImageWithURL:food.restaurant.logoAsURL placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
    [_foodImageView setImageWithURL:food.headerImageAsURL placeholderImage:[UIImage imageNamed:@"LoadingImage"]];
    _sellerLabel.text = [NSString stringWithFormat:@"by %@", food.restaurant.name];
    
    _nameLabel.text = food.title;
    _priceLabel.text = [NSString stringWithFormat:@"$%@", [food priceAtQuantity:@1]];
    _soldLabel.text = [NSString stringWithFormat:@"%@/%@ left", food.orderCount, @([food.remainingOrders floatValue] + [food.orderCount floatValue])];
    _progressBarView.progress = @(food.orderCount.floatValue / food.orderGoal.floatValue).floatValue;
    
    if (food.rating.integerValue > -1) {
        _rateVw.rating = food.rating.floatValue;
    }
    _startDate = food.startDate;
    _endDate = food.endDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    [_startTimeLabel setText:[NSString stringWithFormat:@"AVAILABLE %@", [dateFormatter stringFromDate:food.startDate]]];
    
    self.state = food.state;
    self.timingState = food.timingState;
    self.quantityState = food.quantityState;
}

- (void)setupFoodImage {
    _foodImageView = [[UIImageView alloc] init];
    _foodImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _foodImageView.image = [UIImage imageNamed:@"LoadingImage"];
    _foodImageView.layer.masksToBounds = YES;
    _foodImageView.layer.cornerRadius = 4;
    [self.contentView addSubview:_foodImageView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-22-[_foodImageView]-22-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-23-[_foodImageView]-35-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodImageView)]];
}

- (void)setupCellBG {
    _cellBG = [[UIImageView alloc] init];
    _cellBG.translatesAutoresizingMaskIntoConstraints = NO;
    _cellBG.image = [UIImage imageNamed:@"FoodCell"];
    [self.contentView addSubview:_cellBG];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_cellBG]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cellBG)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_cellBG]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cellBG)]];
}

- (void)setupStartLabel {
    _startTimeLabel = [[UILabel alloc] init];
    _startTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _startTimeLabel.textColor = [UIColor whiteColor];
    _startTimeLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:30.5];
    _startTimeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_startTimeLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_startTimeLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_startTimeLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-60-[_startTimeLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_startTimeLabel)]];
}

- (void)setupSellerLogoImageView
{
    _sellerLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(37, 107, 40, 40)];
    _sellerLogoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _sellerLogoImageView.layer.cornerRadius = CGRectGetWidth(_sellerLogoImageView.bounds) / 2;
    _sellerLogoImageView.layer.masksToBounds = YES;
    _sellerLogoImageView.image = [UIImage imageNamed:@"LoadingSeller"];
    
    _sellerLogoImageView.layer.borderColor = [[UIColor colorWithRed:66/255.0f green:183/255.0f blue:187/255.0f alpha:.6f] CGColor];
    _sellerLogoImageView.layer.borderWidth = 2.0f;

    [self.contentView addSubview:_sellerLogoImageView];
}

- (void)setupSellerLabel
{
    _sellerLabel = [[UILabel alloc] init];
    _sellerLabel.numberOfLines = 1;
    _sellerLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:11];
    _sellerLabel.textColor = [UIColor whiteColor];
    _sellerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_sellerLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_sellerLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_sellerLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_sellerLabel, _sellerLogoImageView, _nameLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sellerLogoImageView]-9-[_sellerLabel(<=142)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-0-[_sellerLabel]" options:0 metrics:nil views:views]];
}

- (void)setupFoodLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14.0f];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_nameLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sellerLogoImageView]-9-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel,_sellerLogoImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-109-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
}

- (void)setupPriceLabel
{
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = [UIColor whiteColor];
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_priceLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-122-[_priceLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel, _sellerLogoImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-37-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel)]];
}

- (void)setupSoldLabel
{
    _soldLabel = [[UILabel alloc] init];
    _soldLabel.font = [UIFont fontWithName:@"Avenir-Light" size:11.0f];
    _soldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _soldLabel.textColor = UIColorFromRGB(0x717171);
    
    [self.contentView addSubview:_soldLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-37-[_soldLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_soldLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_foodImageView]-1-[_soldLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodImageView, _soldLabel)]];
    
}

- (void)setupProgressBar
{
    _progressBarView = [[TYMProgressBarView alloc] init];
    _progressBarView.barBorderWidth = 1.0f;
    _progressBarView.barBorderWidth = 0;
    _progressBarView.barBackgroundColor = UIColorFromRGB(0xDCDCDC);
    _progressBarView.barFillColor = UIColorFromRGB(0x42B7BB);
    _progressBarView.barInnerPadding = 0;
    _progressBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_progressBarView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_progressBarView, _soldLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-37-[_progressBarView]-37-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_soldLabel]-2-[_progressBarView]-8-|" options:0 metrics:nil views:views ]];
}

- (void)setupRating
{
    _rateVw = [RateView rateViewWithRating:0.f];
    _rateVw.starFillMode = StarFillModeHorizontal;
    _rateVw.canRate = NO;
    _rateVw.tag = 88888;
    _rateVw.starSize = 10;
    _rateVw.translatesAutoresizingMaskIntoConstraints = NO;
    _rateVw.starFillColor = [NMColors mainColor];
    
    [self.contentView addSubview:_rateVw];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw, _nameLabel, _foodImageView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rateVw]-88-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_foodImageView]-2-[_rateVw]" options:0 metrics:nil views:views]];
}


- (void)setupOverLay {
    _overlayView = [[UIImageView alloc] init];
    _overlayView.translatesAutoresizingMaskIntoConstraints = NO;
    _overlayView.layer.cornerRadius = 5.0f;
    _overlayView.hidden = YES;

    [self.contentView addSubview:_overlayView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-21-[_overlayView(278)]-21-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_overlayView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[_overlayView(175)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_overlayView)]];
}

- (void)setupFeaturedBadge {
    _featuredBadge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FeaturedBadge"]];
    _featuredBadge.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_featuredBadge];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7-[_featuredBadge]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_featuredBadge)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_featuredBadge]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_featuredBadge)]];
}

#pragma mark - State Handling

- (void)setState:(NMFoodState)state {
    _state = state;
    if (state == NMFoodStateActive) {
        _overlayView.image = nil;
        _overlayView.hidden = YES;
        _overlayView.backgroundColor = [UIColor clearColor];
        _startTimeLabel.hidden = YES;
    } else {
        // If the food is inactive, just say sale ended.
        self.timingState = NMFoodTimingStateExpired;
    }
}

- (void)setTimingState:(NMFoodTimingState)timingState {
    _timingState = timingState;
    if (timingState == NMFoodTimingStateExpired) {
        _overlayView.image = [UIImage imageNamed:@"SaleEndedOverlay"];
        _overlayView.hidden = NO;
        _overlayView.backgroundColor = [UIColor clearColor];
        _startTimeLabel.hidden = YES;
    } else if (timingState == NMFoodTimingStatePending) {
        _overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.24];
        _overlayView.hidden = NO;
        _startTimeLabel.hidden = NO;
    } else {
        self.state = NMFoodStateActive;
    }
}

- (void)setQuantityState:(NMFoodQuantityState)quantityState {
    _quantityState = quantityState;
    if (quantityState == NMFoodQuantityStateSoldOut) {
        _overlayView.image = [UIImage imageNamed:@"SoldOutOverlay"];
        _overlayView.backgroundColor = [UIColor clearColor];
        _overlayView.hidden = NO;
        _startTimeLabel.hidden = YES;
    } else {
        self.state = NMFoodStateActive;
    }
}

@end
