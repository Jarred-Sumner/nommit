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
#import  "MZTimerLabel.h"

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

@property (nonatomic, strong) MZTimerLabel *endTimerLabel;
@property (nonatomic, strong) UIImageView *overlayView;
@property (nonatomic, strong) UIImageView *timeIcon;

@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSDate *startDate;

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
        [self setupStartTimerLabel];
        [self setupNotifyButton];
    }
    return self;
}

- (void)setFood:(NMFood*)food timerEndedBlock:(NMFoodTableViewCellTimerBlock)timerEndedBlock {
    _timerEndedBlock = timerEndedBlock;
    
    [_sellerLogoImageView setImageWithURL:food.seller.logoAsURL placeholderImage:[UIImage imageNamed:@"LoadingSeller"]];
    [_foodImageView setImageWithURL:food.headerImageAsURL placeholderImage:[UIImage imageNamed:@"LoadingImage"]];
    _sellerLabel.text = food.seller.name;

    
    if (![food.endDate isEqualToDate:_endDate]) {
        [_endTimerLabel pause];
        [_endTimerLabel setCountDownToDate:food.endDate];
    }

    if (![food.startDate isEqualToDate:_startDate]) {
        [_startTimerLabel pause];
        [_startTimerLabel setCountDownToDate:food.startDate];
    }
    
    _nameLabel.text = food.title;
    _priceLabel.text = [NSString stringWithFormat:@"$%@", [food priceAtQuantity:@1]];
    _soldLabel.text = [NSString stringWithFormat:@"%@/%@ left", food.orderCount, @([food.remainingOrders floatValue] + [food.orderCount floatValue])];
    _progressBarView.progress = @(food.orderCount.floatValue / food.orderGoal.floatValue).floatValue;
    
    if (food.rating.integerValue > -1) {
        _rateVw.rating = food.rating.floatValue;
    }
    
    if (food.willNotifyUserValue) {
        [_notifyButton setTitle:@"We'll Notify You" forState:UIControlStateNormal];
        _notifyButton.enabled = NO;
        _notifyButton.layer.opacity = 0.5f;

    } else {
        [_notifyButton setTitle:@"Notify Me" forState:UIControlStateNormal];
        _notifyButton.enabled = YES;
        _notifyButton.layer.opacity = 1.0f;
    }

    _startDate = food.startDate;
    _endDate = food.endDate;
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
    _timeIcon = [[UIImageView alloc] init];
    _timeIcon.image = [UIImage imageNamed:@"TimeIcon"];
    _timeIcon.translatesAutoresizingMaskIntoConstraints = NO;
    [_timeIcon setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [_timeIcon setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_timeIcon];
    
    _endTimerLabel = [[MZTimerLabel alloc] init];
    _endTimerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _endTimerLabel.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _endTimerLabel.textColor = UIColorFromRGB(0x979797);
    _endTimerLabel.timerType = MZTimerLabelTypeTimer;
    _endTimerLabel.timeFormat = @"HH:mm:ss 'left'";
    _endTimerLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_endTimerLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_timeIcon, _endTimerLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_timeIcon]-5-[_endTimerLabel]-18-|" options:0 metrics:nil views:views]];

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[_timeIcon]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_endTimerLabel]" options:0 metrics:nil views:views]];
    
}

- (void)setupOverLay {
    _overlayView = [[UIImageView alloc] initWithFrame:CGRectMake(65, 36, 241, 202)];
    _overlayView.hidden = YES;
    [self.contentView addSubview:_overlayView];
}

- (void)setState:(NMFoodCellState)cellState {
    _state = cellState;
    switch (cellState) {
        case NMFoodCellStateFuture: {
            [_endTimerLabel pause];
            [_startTimerLabel startWithEndingBlock:_timerEndedBlock];
            _startTimerLabel.hidden = NO;
            _notifyButton.hidden = NO;
            
            _overlayView.image = nil;
            _overlayView.hidden = YES;
            _soldLabel.hidden = YES;
            _rateVw.hidden = YES;
            _progressBarView.hidden = YES;
            _timeIcon.hidden = YES;
            _endTimerLabel.hidden = YES;
            _timeIcon.hidden = YES;

            break;
        }
        case NMFoodCellStateSoldOut:
            [_endTimerLabel pause];
            [_startTimerLabel pause];
            _overlayView.image = [UIImage imageNamed:@"SoldOutOverlay"];
            _overlayView.hidden = NO;
            
            _startTimerLabel.hidden = YES;
            _notifyButton.hidden = YES;
            _soldLabel.hidden = NO;
            _rateVw.hidden = NO;
            _progressBarView.hidden = NO;
            _timeIcon.hidden = NO;
            _endTimerLabel.hidden = YES;
            _timeIcon.hidden = YES;

            break;
        case NMFoodCellStateExpired:
            [_endTimerLabel pause];
            [_startTimerLabel pause];
            _overlayView.image = [UIImage imageNamed:@"SaleEndedOverlay"];
            _overlayView.hidden = NO;

            _startTimerLabel.hidden = YES;
            _notifyButton.hidden = YES;
            _soldLabel.hidden = NO;
            _rateVw.hidden = NO;
            _progressBarView.hidden = NO;
            _timeIcon.hidden = NO;
            _endTimerLabel.hidden = YES;
            _timeIcon.hidden = YES;

            break;
        case NMFoodCellStateNormal:
            [_endTimerLabel startWithEndingBlock:_timerEndedBlock];
            [_startTimerLabel pause];
            _overlayView.image = nil;
            _overlayView.hidden = YES;

            _startTimerLabel.hidden = YES;
            _notifyButton.hidden = YES;
            _soldLabel.hidden = NO;
            _rateVw.hidden = NO;
            _progressBarView.hidden = NO;
            _timeIcon.hidden = NO;
            _endTimerLabel.hidden = NO;
            _timeIcon.hidden = NO;

            break;
        default:
            break;
    }
}

- (void)setupStartTimerLabel
{
    _startTimerLabel = [[MZTimerLabel alloc] init];
    _startTimerLabel.timeLabel.font = [UIFont fontWithName:@"Avenir-Black" size:50];
    _startTimerLabel.timeLabel.textColor = [UIColor whiteColor];
    _startTimerLabel.timeLabel.alpha = .95;
    _startTimerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _startTimerLabel.textAlignment = NSTextAlignmentCenter;
    _startTimerLabel.timeFormat = @"HH:mm:ss";
    _startTimerLabel.timerType = MZTimerLabelTypeTimer;
    [_foodImageView addSubview:_startTimerLabel];
    
    [_foodImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_startTimerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_startTimerLabel)]];
    
    [_foodImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_startTimerLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_startTimerLabel)]];
}

- (void)setupNotifyButton {
    _notifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _notifyButton.layer.cornerRadius = 2;
    _notifyButton.backgroundColor = [NMColors mainColor];
    [_notifyButton setTitle:@"Notify Me" forState:UIControlStateNormal];
    [_notifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _notifyButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:12];
    _notifyButton.frame = CGRectMake(67, 238.5-35, 241-4.5, 33);
    
    [self.contentView addSubview:_notifyButton];
}

- (void)dealloc {
    _timerEndedBlock = NULL;
}
@end
