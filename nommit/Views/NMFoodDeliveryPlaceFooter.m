//
//  NMFoodDeliveryPlaceFooter.m
//  nommit
//
//  Created by Lucy Guo on 9/28/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodDeliveryPlaceFooter.h"
#import "NMColors.h"

@implementation NMFoodDeliveryPlaceFooter

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupHereButton];
        [self setupDoneButton];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hereButton(160)]-0-[_doneButton(160)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hereButton, _doneButton)]];
        [self setupRevenueLabel];
    }
    return self;
}

- (void)setupHereButton
{
    _hereButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _hereButton.backgroundColor = [NMColors mainColor];
    _hereButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_hereButton setTitle:@"I'm here" forState:UIControlStateNormal];
    [_hereButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addSubview:_hereButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_hereButton(44)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hereButton)]];
}

- (void)setupDoneButton
{
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.backgroundColor = UIColorFromRGB(0xF0F0F0);
    [_doneButton setTitle:@"End Shift" forState:UIControlStateNormal];
    [_doneButton setTitleColor:UIColorFromRGB(0x404040) forState:UIControlStateNormal];
    _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_doneButton];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_doneButton(44)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_doneButton)]];
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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[whiteBackround(40)]-0-[_hereButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(whiteBackround, _hereButton)]];
    
}

@end
