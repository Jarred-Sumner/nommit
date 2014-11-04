//
//  NMFoodDeliveryPlaceFooter.m
//  nommit
//
//  Created by Lucy Guo on 9/28/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryPlaceFooter.h"
#import "NMColors.h"

@implementation NMDeliveryPlaceFooter

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDoneButton];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_endShiftButton(320)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_endShiftButton)]];
        [self setupRevenueLabel];
    }
    return self;
}

- (void)setupDoneButton
{
    _endShiftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _endShiftButton.backgroundColor = [NMColors mainColor];
    [_endShiftButton setTitle:@"End Shift" forState:UIControlStateNormal];
    [_endShiftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _endShiftButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_endShiftButton];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_endShiftButton(44)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_endShiftButton)]];
}

- (void)setupRevenueLabel
{
    UIView *whiteBackround = [[UIView alloc] init];
    whiteBackround.backgroundColor = [UIColor whiteColor];
    whiteBackround.translatesAutoresizingMaskIntoConstraints = NO;
    whiteBackround.layer.borderWidth = 1.0f;
    whiteBackround.layer.borderColor = [UIColorFromRGB(0xC7C7C7) CGColor];
    [self addSubview:whiteBackround];
    
    _revenueLabel = [[UILabel alloc] init];
    _revenueLabel.font = [UIFont fontWithName:@"Avenir" size:18.0f];
    _revenueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _revenueLabel.textColor = UIColorFromRGB(0x666666);
    _revenueLabel.textAlignment = NSTextAlignmentCenter;
    [whiteBackround addSubview:_revenueLabel];
    
    
    [whiteBackround addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_revenueLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_revenueLabel)]];
    [whiteBackround addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_revenueLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_revenueLabel)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[whiteBackround]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(whiteBackround)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[whiteBackround(40)]-0-[_endShiftButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(whiteBackround, _endShiftButton)]];
    
}

@end
