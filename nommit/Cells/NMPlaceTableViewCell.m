//
//  NMLocationTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPlaceTableViewCell.h"
#import "NMColors.h"

@implementation NMPlaceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.textLabel.textColor = UIColorFromRGB(0x757575);
    self.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];

    [self setupLabel];
    [self setupIcon];

    NSDictionary *views = NSDictionaryOfVariableBindings(_numberOfFoodAvailableLabel, _iconImageView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_iconImageView]-5-[_numberOfFoodAvailableLabel]-15-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_numberOfFoodAvailableLabel]-2-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[_iconImageView]-14-|" options:0 metrics:nil views:views]];

    return self;
}

- (void)setupIcon {
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"ForkKnife"];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [self.contentView addSubview:_iconImageView];
}

- (void)setupLabel
{
    _numberOfFoodAvailableLabel = [[UILabel alloc] init];
    _numberOfFoodAvailableLabel.textColor = UIColorFromRGB(0x009297);
    _numberOfFoodAvailableLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    _numberOfFoodAvailableLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_numberOfFoodAvailableLabel];
}

@end
