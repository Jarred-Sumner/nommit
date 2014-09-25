//
//  NMOrderLocationView.m
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderLocationView.h"
#import "NMColors.h"

@implementation NMOrderLocationView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NMColors mainColor];
        [self setupNameLabel];
        [self setupNextLabel];
        [self setupArrows];
    }
    return self;
}

- (void)setupNameLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:17];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nameLabel]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupNextLabel
{
    _nextLabel = [[UILabel alloc] init];
    _nextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nextLabel.textColor = [UIColor whiteColor];
    _nextLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:12];
    _nextLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nextLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nextLabel, _nameLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nextLabel]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-0-[_nextLabel]" options:0 metrics:nil views:views]];
}

- (void)setupArrows
{
    _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightArrow.contentMode = UIViewContentModeScaleAspectFill;
    _rightArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_rightArrow setImage:[UIImage imageNamed:@"RightArrow"] forState:UIControlStateNormal];
    [self addSubview:_rightArrow];
    
    _leftArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftArrow.contentMode = UIViewContentModeScaleAspectFill;
    _leftArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_leftArrow setImage:[UIImage imageNamed:@"LeftArrow"] forState:UIControlStateNormal];
    [self addSubview:_leftArrow];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rightArrow, _leftArrow);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightArrow]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_leftArrow]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_rightArrow]-11-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_leftArrow]-11-|" options:0 metrics:nil views:views]];
    
}

@end
