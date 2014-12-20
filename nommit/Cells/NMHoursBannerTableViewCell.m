//
//  NMHoursBannerTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 12/18/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMHoursBannerTableViewCell.h"

@interface NMHoursBannerTableViewCell ()

@property (nonatomic, strong) UIImageView *foodAvailableImageView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation NMHoursBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *bannerImage = [[UIImageView alloc] initWithFrame:self.bounds];
        bannerImage.contentMode = UIViewContentModeScaleAspectFill;

        [self setBackgroundView:bannerImage];
        
        
        UIView *overlay = [[UIView alloc] init];
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25];
        overlay.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.backgroundView addSubview:overlay];
        [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[overlay]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(overlay)]];
        [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[overlay]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(overlay)]];
        
        self.foodAvailableImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FoodAvailable"]];
        self.foodAvailableImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.foodAvailableImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.foodAvailableImageView];
        
        [self setupHoursLabel];
        [self setupTipLabel];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_foodAvailableImageView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodAvailableImageView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_foodAvailableImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_foodAvailableImageView)]];
    }
    return self;
}

- (void)setupHoursLabel {
    _hoursLabel = [[UILabel alloc] init];
    _hoursLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _hoursLabel.font = [UIFont fontWithName:@"Avenir" size:15.0];
    _hoursLabel.textColor = [UIColor whiteColor];
    _hoursLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_hoursLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hoursLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_hoursLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
}

- (void)setupTipLabel {
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _tipLabel.font = [UIFont fontWithName:@"Avenir" size:13.f];
    _tipLabel.textColor = [UIColor whiteColor];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.text = @"(Tip Included)";
    [self.contentView addSubview:_tipLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tipLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tipLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tipLabel]-35-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tipLabel)]];
}

@end
