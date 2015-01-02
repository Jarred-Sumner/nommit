//
//  NMBecomeASellerFooterView.m
//  nommit
//
//  Created by Lucy Guo on 12/30/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMBecomeASellerFooterView.h"

@implementation NMBecomeASellerFooterView


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addBackground];
        [self addIcons];
        [self addFooterLabel];
        [self setupFooterText];
        [self setupFooterButton];
    }
    return self;
}

- (void)addBackground {
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FooterBG"]];
    bg.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:bg];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bg]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bg)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[bg]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bg)]];
}

- (void)addIcons {
    UIImageView *dollarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DollarIcon"]];
    dollarIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *chefIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ChefIcon"]];
    chefIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *peopleIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PeopleIcon"]];
    peopleIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:dollarIcon];
    [self addSubview:chefIcon];
    [self addSubview:peopleIcon];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-32-[dollarIcon(52)]-50-[chefIcon(52)]-50-[peopleIcon(52)]-32-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dollarIcon, chefIcon, peopleIcon)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dollarIcon(52)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dollarIcon)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[chefIcon(52)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chefIcon)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[peopleIcon(52)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(peopleIcon)]];
}

- (void)addFooterLabel {
    UIImageView *footerLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FooterLabel"]];
    footerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:footerLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-68-[footerLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footerLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-70-[footerLabel]-70-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(footerLabel)]];
}

- (void)setupFooterText {
    _footerText = [[UILabel alloc] init];
    _footerText.translatesAutoresizingMaskIntoConstraints = NO;
    _footerText.font = [UIFont fontWithName:@"Avenir" size:12.5];
    _footerText.numberOfLines = 0;
    _footerText.textAlignment = NSTextAlignmentCenter;
    _footerText.lineBreakMode = NSLineBreakByWordWrapping;
    _footerText.textColor = UIColorFromRGB(0x7A7A7A);
    [self addSubview:_footerText];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-102-[_footerText]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerText)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[_footerText]-25-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerText)]];
}

- (void)setupFooterButton {
    _footerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_footerButton setImage:[UIImage imageNamed:@"FooterButton"] forState:UIControlStateNormal];
    _footerButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_footerButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_footerText]-18-[_footerButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerButton, _footerText)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_footerButton]-30-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerButton)]];
}

@end
