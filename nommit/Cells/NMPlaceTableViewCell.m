//
//  NMLocationTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPlaceTableViewCell.h"
#import "NMColors.h"

@interface NMPlaceTableViewCell()

@property (nonatomic, strong) UIImageView *whiteBackground;

@end

@implementation NMPlaceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = UIColorFromRGB(0x757575);
    self.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self setupWhiteBackground];
    [self setupPlaceLabel];
    [self setupLabel];
    [self setupIcon];

    NSDictionary *views = NSDictionaryOfVariableBindings(_numberOfFoodAvailableLabel, _iconImageView);
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_numberOfFoodAvailableLabel]-5-[_iconImageView]-15-|" options:0 metrics:nil views:views]];
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_numberOfFoodAvailableLabel]-2-|" options:0 metrics:nil views:views]];
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_iconImageView]-13-|" options:0 metrics:nil views:views]];

    return self;
}

- (void)setupWhiteBackground {
    _whiteBackground = [[UIImageView alloc] init];
    _whiteBackground.image = [UIImage imageNamed:@"PlaceTableViewCellBG"];
    _whiteBackground.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_whiteBackground];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_whiteBackground]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_whiteBackground)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_whiteBackground]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_whiteBackground)]];
}

- (void)setupPlaceLabel {
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.textColor = UIColorFromRGB(0x6C6C6C);
    _placeLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    _placeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_whiteBackground addSubview:_placeLabel];
    
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_placeLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeLabel)]];
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_placeLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeLabel)]];
}

- (void)setupIcon {
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"ForkKnifeCircle"];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [_whiteBackground addSubview:_iconImageView];
}

- (void)setupLabel
{
    _numberOfFoodAvailableLabel = [[UILabel alloc] init];
    _numberOfFoodAvailableLabel.textColor = UIColorFromRGB(0x009297);
    _numberOfFoodAvailableLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    _numberOfFoodAvailableLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_whiteBackground addSubview:_numberOfFoodAvailableLabel];
}

@end
