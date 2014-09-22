//
//  NMLocationDropdownTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/19/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLocationDropdownTableViewCell.h"
#import "NMColors.h"

@implementation NMLocationDropdownTableViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _locationButton.contentMode = UIViewContentModeScaleAspectFill;
        _locationButton.translatesAutoresizingMaskIntoConstraints = NO;
        _locationButton.backgroundColor = [NMColors mainColor];
        [self addSubview:_locationButton];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_locationButton);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_locationButton]-0-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_locationButton]-0-|" options:0 metrics:nil views:views]];
        self.backgroundColor = [NMColors mainColor];
    }
    return self;
}

@end
