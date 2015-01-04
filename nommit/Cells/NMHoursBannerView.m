//
//  NMHoursBannerTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 12/18/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMHoursBannerView.h"

@interface NMHoursBannerView ()

@property (nonatomic, strong) UIImageView *foodAvailableImageView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation NMHoursBannerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.clipsToBounds = YES;
    
    self.backgroundColor = UIColorFromRGB(0x737373);
    
    _hoursLabel = [[UILabel alloc] init];
    _hoursLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _hoursLabel.textColor = [UIColor whiteColor];
    _hoursLabel.font = [UIFont fontWithName:@"Avenir-BookOblique" size:13];
    _hoursLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_hoursLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hoursLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_hoursLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];

    return self;
}


@end
