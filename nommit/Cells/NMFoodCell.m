//
//  NMSmallFlashSaleCell.m
//  nommit
//
//  Created by Lucy Guo on 8/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodCell.h"
#import "NMColors.h"

@interface NMFoodCell()

@property (nonatomic, strong) UIImageView *foodImageView;
@property (nonatomic, strong) UILabel *soldLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TYMProgressBarView *progressBarView;

@end

@implementation NMFoodCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupBackgroundView];
    [self setupFoodImageView];
    [self setupNameLabel];
    [self setupSoldLabel];
    [self setupPriceLabel];
    [self setupProgressBar];
    return self;
}

- (void)setFood:(NMFood *)food {
    _food = food;
    
    _nameLabel.text  = food.title;
    _priceLabel.text = [NSString stringWithFormat:@"$%@", food.price];
    _soldLabel.text = [NSString stringWithFormat:@"%@ left (%@ total)", @(food.orderGoal.integerValue - food.orderCount.integerValue), food.orderGoal];
    [_foodImageView setImageWithURL:[food thumbnailImageAsURL]];
}

- (void)setupBackgroundView {
    self.backgroundView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    [(UIImageView*)self.backgroundView setImage:[UIImage imageNamed:@"FoodItemCell"]];
}

- (void)setupFoodImageView {
    _foodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetWidth(self.contentView.frame))];
    [self.contentView addSubview:_foodImageView];
}

- (void)setupNameLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _nameLabel.textColor = UIColorFromRGB(0x3C3C3C);
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_nameLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-145-[_nameLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel)]];
}

- (void)setupSoldLabel
{
    _soldLabel = [[UILabel alloc] init];
    _soldLabel.font = [UIFont fontWithName:@"Avenir-Light" size:10.0f];
    _soldLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _soldLabel.textColor = UIColorFromRGB(0x717171);
    
    [self.contentView addSubview:_soldLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_soldLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_soldLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-145-[_nameLabel]-2-[_soldLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel, _soldLabel)]];

}

- (void)setupProgressBar
{
    // Create a progress bar view and set its appearance
    _progressBarView = [[TYMProgressBarView alloc] initWithFrame:CGRectMake(10, CGRectGetHeight(_foodImageView.frame) + 38, CGRectGetWidth(self.contentView.frame) - 20, 6.5f)];
    _progressBarView.barBorderWidth = 1.0f;
    _progressBarView.barBorderWidth = 0;
    _progressBarView.barBackgroundColor = UIColorFromRGB(0xDCDCDC);
    _progressBarView.barFillColor = UIColorFromRGB(0x42B7BB);
    _progressBarView.barInnerPadding = 0;
    _progressBarView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_progressBarView];
}

- (void)setupPriceLabel
{
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:12.0f];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = UIColorFromRGB(0x60C4BE);
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.contentView addSubview:_priceLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-145-[_priceLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceLabel)]];

}


@end
