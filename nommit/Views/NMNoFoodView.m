//
//  NMNoFoodView.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMNoFoodView.h"

@implementation NMNoFoodView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupChefIcon];
        [self setupLabel];
    }
    return self;
}

- (void)setupChefIcon {
    UIImageView *chef = [[UIImageView alloc] init];
    chef.translatesAutoresizingMaskIntoConstraints = NO;
    chef.image = [UIImage imageNamed:@"Chef"];
    [self addSubview:chef];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-78-[chef]-78-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chef)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-101-[chef]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(chef)]];
}

- (void)setupLabel {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont fontWithName:@"Avenir" size:16];
    label.textColor = UIColorFromRGB(0xB2B2B2);
    label.text = @"No food available right now. Please check back later!";
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    
    [self addSubview:label];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-54-[label]-54-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-28-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
}

@end
