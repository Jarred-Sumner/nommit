//
//  NMLocationDropdownTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMPlaceDropdownView.h"
#import "NMColors.h"

@implementation NMPlaceDropdownView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.contentMode = UIViewContentModeScaleAspectFill;
        _locationButton.translatesAutoresizingMaskIntoConstraints = NO;
        _locationButton.backgroundColor = [NMColors mainColor];
        _locationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _locationButton.titleLabel.textColor = [UIColor whiteColor];
        _locationButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _locationButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        [self addSubview:_locationButton];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArrowIcon"]];
        arrow.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:arrow];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_locationButton, arrow);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_locationButton]-0-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_locationButton]-0-|" options:0 metrics:nil views:views]];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[arrow]-15-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[arrow]" options:0 metrics:nil views:views]];
    }
    return self;
}

@end
