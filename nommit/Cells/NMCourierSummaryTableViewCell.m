//
//  NMCourierSummaryTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/30/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMCourierSummaryTableViewCell.h"
#import "NMColors.h"

@implementation NMCourierSummaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    [self setupAmountLabel];
    [self setupSubtitleLabel];
    [self setupIconImageView];
    
    [self setupConstraints];
    
    [self addBorder];

    return self;
}

- (void)setupAmountLabel
{
    _amountLabel = [[UILabel alloc] init];
    _amountLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _amountLabel.font = [UIFont fontWithName:@"Avenir" size:25];
    _amountLabel.textColor = UIColorFromRGB(0x686868);
    [self.contentView addSubview:_amountLabel];
}

- (void)setupSubtitleLabel
{
    _subtitleLabel = [[UILabel alloc] init];
    _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _subtitleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
    _subtitleLabel.textColor = UIColorFromRGB(0x686868);
    [self.contentView addSubview:_subtitleLabel];
}

- (void)setupIconImageView
{
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_iconImageView];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_amountLabel, _subtitleLabel, _iconImageView);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_amountLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-38-[_subtitleLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_iconImageView]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_iconImageView]-15-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_amountLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_subtitleLabel]" options:0 metrics:nil views:views]];
}

- (void)addBorder
{
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = UIColorFromRGB(0xDFDFDF);
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:borderView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
}



@end
