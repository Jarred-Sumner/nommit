//
//  NMLocationTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMListTableViewCell.h"
#import "NMColors.h"

@interface NMListTableViewCell()

@property (nonatomic, strong) UIImageView *whiteBackground;

@end

@implementation NMListTableViewCell

@synthesize textLabel = _textLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = UIColorFromRGB(0x757575);
    self.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self setupWhiteBackground];
    [self setupTextLabel];
    [self setupLabel];
    [self setupIcon];

    NSDictionary *views = NSDictionaryOfVariableBindings(_accessoryLabel, _iconImageView);
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_accessoryLabel]-5-[_iconImageView]-15-|" options:0 metrics:nil views:views]];
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_accessoryLabel]-2-|" options:0 metrics:nil views:views]];
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

- (void)setupTextLabel {
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = UIColorFromRGB(0x6C6C6C);
    _textLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_whiteBackground addSubview:_textLabel];
    
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_textLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];
    [_whiteBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];
}

- (void)setupIcon {
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.image = [UIImage imageNamed:@"ForkKnifeCircle"];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;

    [_whiteBackground addSubview:_iconImageView];
}

- (void)setupLabel
{
    _accessoryLabel = [[UILabel alloc] init];
    _accessoryLabel.textColor = UIColorFromRGB(0x009297);
    _accessoryLabel.font = [UIFont fontWithName:@"Avenir" size:16];
    _accessoryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_whiteBackground addSubview:_accessoryLabel];
}

@end
