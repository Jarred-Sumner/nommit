//
//  NMDeliveryPlaceHeaderView.m
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryPlaceHeaderView.h"


@implementation NMDeliveryPlaceHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPlaceNumber];
        [self setupPlaceName];
        [self setupPlaceTime];
        [self setupArrivalButton];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setupPlaceNumber {
    
}

- (void)setupPlaceName {
    _placeName = [[UILabel alloc] init];
    _placeName.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
    _placeName.textAlignment = NSTextAlignmentRight;
    _placeName.textColor = [UIColor whiteColor];
    _placeName.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:_placeName];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_placeName]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeName)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[_placeName]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeName)]];
}

- (void)setupPlaceTime {
    
}

- (void)setupArrivalButton {
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrivalButton setBackgroundImage:[UIImage imageNamed:@"ArrivedButton"] forState:UIControlStateNormal];
    _arrivalButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:14];
    _arrivalButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_arrivalButton setTitle:@"arrived" forState:UIControlStateNormal];
    
    [self addSubview:_arrivalButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_arrivalButton]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_arrivalButton)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_arrivalButton]-7-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_arrivalButton)]];
    
}

- (void)setUrgency:(NMDeliveryUrgency)urgency {
    if (urgency == NMDeliveryUrgencyHigh) {
        self.backgroundColor = UIColorFromRGB(0xB00000);
        [_arrivalButton setTitleColor:UIColorFromRGB(0xB00000) forState:UIControlStateNormal];
    } else if (urgency == NMDeliveryUrgencyMed) {
        self.backgroundColor = UIColorFromRGB(0xE9931E);
        [_arrivalButton setTitleColor:UIColorFromRGB(0xE9931E) forState:UIControlStateNormal];
    } else {
        self.backgroundColor = UIColorFromRGB(0x47DA80);
        [_arrivalButton setTitleColor:UIColorFromRGB(0x47DA80) forState:UIControlStateNormal];
    }
}

@end
