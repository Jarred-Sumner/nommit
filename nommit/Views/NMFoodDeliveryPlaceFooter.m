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
        [self setupTopBorders];
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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hereButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hereButton)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_hereButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hereButton)]];
}

- (void)setupDoneButton
{
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.backgroundColor = UIColorFromRGB(0xF0F0F0);
    [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [_doneButton setTitleColor:UIColorFromRGB(0x404040) forState:UIControlStateNormal];
    _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_doneButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_hereButton(160)]-[_doneButton(160)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hereButton, _doneButton, _hereButton)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_doneButton]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_doneButton)]];
}

- (void)setupTopBorders
{
    UIView *leftBorder = [[UIView alloc] init];
    leftBorder.backgroundColor = UIColorFromRGB(0x009297);
    leftBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:leftBorder];
    
    UIView *rightBorder = [[UIView alloc] init];
    rightBorder.backgroundColor = UIColorFromRGB(0xB6B6B6);
    rightBorder.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:rightBorder];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[leftBorder(160)]-[rightBorder(160)]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBorder, rightBorder)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[leftBorder(1)]-[_doneButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_doneButton, leftBorder)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[rightBorder(1)]-[_doneButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_doneButton, rightBorder)]];
}

@end
