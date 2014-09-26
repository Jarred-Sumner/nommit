//
//  NMTableSeparatorView.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMTableSeparatorView.h"
#import "NMColors.h"

@implementation NMTableSeparatorView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSectionLabel];
        [self setupLine];
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
    }
    return self;
}

- (void)setupSectionLabel {
    _sectionLabel = [[UILabel alloc] init];
    _sectionLabel.textColor = UIColorFromRGB(0x009297);
    _sectionLabel.font = [UIFont fontWithName:@"Avenir" size:11.0f];
    _sectionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_sectionLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_sectionLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sectionLabel)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_sectionLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sectionLabel)]];
}

- (void)setupLine {
    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(24, 38, self.frame.size.width - 5, 1)];
    separatorLine.backgroundColor = UIColorFromRGB(0x009297);
    [self addSubview:separatorLine];
}

@end
