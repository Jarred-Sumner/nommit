//
//  NMSupportView.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSupportView.h"
#import "NMColors.h"

@implementation NMSupportView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        [self setupCallButton];
        [self setupEmailButton];
        
    }
    return self;
}

- (void)setupCallButton {
    _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _callButton.backgroundColor = [NMColors mainColor];
    _callButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [_callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _callButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_callButton setTitle:@"Call Us" forState:UIControlStateNormal];
    
    [self addSubview:_callButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_callButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_callButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton)]];
}

- (void)setupEmailButton {
    _emailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _emailButton.backgroundColor = UIColorFromRGB(0x009297);
    _emailButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [_emailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _emailButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_emailButton setTitle:@"Email Us" forState:UIControlStateNormal];
    
    [self addSubview:_emailButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_emailButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emailButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_callButton(44)]-15-[_emailButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton, _emailButton)]];

}

@end
