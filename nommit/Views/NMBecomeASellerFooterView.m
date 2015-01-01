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
        // [self addIcons];
    }
    return self;
}

- (void)addBackground {
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FooterBG"]];
    bg.frame = self.frame;
    [self addSubview:bg];
}

- (void)addIcons {
    UIImageView *dollarIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DollarIcon"]];
    dollarIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:dollarIcon];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dollarIcon(52)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dollarIcon)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dollarIcon(52)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(dollarIcon)]];
}

@end
