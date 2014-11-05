//
//  NMFoodTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodTableViewCell.h"
#import "TYMProgressBarView.h"
#import "NMColors.h"
#import "NMMenuNavigationController.h"
#import "NMFoodCellHeaderView.h"
#import "RateView.h"

@interface NMFoodTableViewCell()

@property (nonatomic, strong) UIImageView *foodImageView;
@property (nonatomic, strong) NMFoodCellHeaderView *headerView;
@property (nonatomic, strong) UILabel *soldLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *sellerLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TYMProgressBarView *progressBarView;
@property (nonatomic, strong) UIImageView *sellerLogoImageView;
@property (nonatomic, strong) RateView *rateVw;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *overlayView;

@end

@implementation NMFoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(65, 38, 241, 200.5)];
        bg.image = [UIImage imageNamed:@"NewsCell"];
        [self.contentView addSubview:bg];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSellerLogoImageView];
        [self setupTime];
        [self setupSellerLabel];
        [self setupFoodImageView];
        [self setupFoodLabel];
        [self setupPriceLabel];
        [self setupSoldLabel];
        [self setupProgressBar];
        [self setupRating];
        [self setupOverLay];
    }
    return self;
}

- (void)setFood:(NMFood *)food arrivalTime:(NSDate*)arrivalTime {
    _arrivalTime = arrivalTime;
    
    [_sellerLogoImageView setImageWithURL:food.seller.logoAsURL placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
    [_foodImageView setImageWithURL:food.headerImageAsURL placeholderImage:[UIImage imageNamed:@"LoadingImage"]];
    _sellerLabel.text = food.seller.name;
    _timeLabel.text = [self arrivalTimeText];
    
    _nameLabel.text = food.title;
    _priceLabel.text = [NSString stringWithFormat:@"$%@", [food priceAtQuantity:@1]];
    _soldLabel.text = [NSString stringWithFormat:@"%@/%@ left", food.orderCount, @([food.remainingOrders floatValue] + [food.orderCount floatValue])];
    _progressBarView.progress = @(food.orderCount.floatValue / food.orderGoal.floatValue).floatValue;
    
    if (food.rating.integerValue > -1) {
        _rateVw.rating = food.rating.floatValue;
    }
    
    if ([food.endDate compare:[NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24]] == NSOrderedAscending) {
        _overlayView.hidden = NO;
    } else {
        _overlayView.hidden = YES;
    }
    
}

- (void)setupSellerLogoImageView
{
    _sellerLogoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 18, 40, 40)];
    _sellerLogoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _sellerLogoImageView.layer.cornerRadius = CGRectGetWidth(_sellerLogoImageView.bounds) / 2;
    _sellerLogoImageView.layer.masksToBounds = YES;
    _sellerLogoImageView.image = [UIImage imageNamed:@"LoadingSeller"];
    
    _sellerLabel.layer.borderColor = [UIColorFromRGB(0xE4E4E4) CGColor];
    _sellerLabel.layer.borderWidth = 2.0f;

    [self.contentView addSubview:_sellerLogoImageView];
}

- (void)setupSellerLabel
{
    _sellerLabel = [[UILabel alloc] init];
    _sellerLabel.numberOfLines = 1;
    _sellerLabel.font = [UIFont fontWithName:@"Avenir" size:12];
    _sellerLabel.textColor = UIColorFromRGB(0x3C3C3C);
    _sellerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_sellerLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_sellerLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_sellerLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_sellerLabel, _sellerLogoImageView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sellerLogoImageView]-14-[_sellerLabel(<=142)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_sellerLabel]" options:0 metrics:nil views:views]];
}

- (void)setupFoodImageView
{
    _foodImageView = [[UIImageView alloc] init];
    _foodImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _foodImageView.image = [UIImage imageNamed:@"LoadingImage"];
    _foodImageView.layer.masksToBounds = YES;
    _foodImageView.layer.cornerRadius = 2;
    _foodImageView.contentMode = UIViewContentModeScaleAspectFill;

    [self.contentView addSubview:_foodImageView];
    
    // _foodImageView.frame = CGRectMake(67, 38, 241, 200.5);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-67-[_foodImageView]-16-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-38-[_foodImageView]-75-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodImageView)]];
}

- (void)setupFoodLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    _nameLabel.textColor = UIColorFromRGB(0x3C3C3C);
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_nameLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-77-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_foodImageView]-7-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel, _foodImageView)]];
}

- (void)setupPriceLabel
{
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = UIColorFromRGB(0x60C4BE);
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_priceLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_foodImageView]-7-[_priceLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel, _foodImageView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel)]];
}

- (void)setupSoldLabel
{
    _soldLabel = [[UILabel alloc] init];
    _soldLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    _soldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _soldLabel.textColor = UIColorFromRGB(0x717171);
    
    [self.contentView addSubview:_soldLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-77-[_soldLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_soldLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-3-[_soldLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel, _soldLabel)]];
    
}

- (void)setupProgressBar
{
    // Create a progress bar view and set its appearance
    _progressBarView = [[TYMProgressBarView alloc] init];
    _progressBarView.barBorderWidth = 1.0f;
    _progressBarView.barBorderWidth = 0;
    _progressBarView.barBackgroundColor = UIColorFromRGB(0xDCDCDC);
    _progressBarView.barFillColor = UIColorFromRGB(0x42B7BB);
    _progressBarView.barInnerPadding = 0;
    _progressBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_progressBarView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_progressBarView, _soldLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-77-[_progressBarView]-25-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_soldLabel]-5-[_progressBarView]-15-|" options:0 metrics:nil views:views ]];
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
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw, _nameLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rateVw]-75-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-6-[_rateVw]" options:0 metrics:nil views:views]];
}

- (void)setupTime
{
    UIImageView *timeIcon = [[UIImageView alloc] init];
    timeIcon.image = [UIImage imageNamed:@"TruckIcon"];
    timeIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [timeIcon setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [timeIcon setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:timeIcon];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timeLabel.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _timeLabel.textColor = UIColorFromRGB(0x979797);
    _timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_timeLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(timeIcon, _timeLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[timeIcon]-5-[_timeLabel]-18-|" options:0 metrics:nil views:views]];

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[timeIcon]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_timeLabel]" options:0 metrics:nil views:views]];
    
}

- (void)setupOverLay {
    _overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(65, 36, 241, 202)];
    _overlayView.image = [UIImage imageNamed:@"SoldOutOverlay"];
    [self.contentView addSubview:_overlayView];
}

#pragma mark - Utility Methods

- (NSString *)arrivalTimeText {
    if ([_arrivalTime timeIntervalSinceNow] > 60 * 2) {
        TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        timeIntervalFormatter.usesAbbreviatedCalendarUnits = YES;
        timeIntervalFormatter.futureDeicticExpression = @"";
        return [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:_arrivalTime];
    } else if ([_arrivalTime timeIntervalSinceNow] > 0) {
        return @"2 mins";
    } else {
        return @"15 mins";
    }
}
@end
