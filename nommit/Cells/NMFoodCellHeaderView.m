//
//  NMFoodCellHeaderView.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMFoodCellHeaderView.h"

@interface NMFoodCellHeaderView()
@end

@implementation NMFoodCellHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = .95f;
        [self setupAvatar];
        [self setupLabel];
        [self setupRating];
    }
    return self;
}

- (void)setupAvatar
{
    _profileAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(14, 9, 35, 35)];
    _profileAvatar.layer.cornerRadius = CGRectGetWidth(_profileAvatar.bounds) / 2;
    _profileAvatar.contentMode = UIViewContentModeScaleAspectFit;
    _profileAvatar.layer.masksToBounds = YES;
    _profileAvatar.image = [UIImage imageNamed:@"AvatarLucySmall"];
    [self addSubview:_profileAvatar];
}

- (void)setupLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:14];
    _nameLabel.textColor = UIColorFromRGB(0x3C3C3C);
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-65-[_nameLabel]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupRating
{
    _rateVw = [RateView rateViewWithRating:5.0f];
    _rateVw.starFillMode = StarFillModeHorizontal;
    _rateVw.canRate = NO;
    _rateVw.tag = 88888;
    _rateVw.starSize = 10;
    _rateVw.translatesAutoresizingMaskIntoConstraints = NO;
    
    _rateVw.starFillColor = [NMColors mainColor];
    
    
    [self addSubview:_rateVw];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-65-[_rateVw]-220-|" options:0 metrics:nil views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_rateVw]-10-|" options:0 metrics:nil views:views]];
    

}

@end
