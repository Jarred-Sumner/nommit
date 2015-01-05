//
//  NMFooterRequestView.m
//  nommit
//
//  Created by Lucy Guo on 1/4/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMFooterRequestView.h"
#import "UILabel+Boldify.h"

@implementation NMFooterRequestView

- (id)initWithText:(NSString *)regularString withUnderlinedString:(NSString *)underlinedString withFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLabelWithRegularString:regularString withUnderlinedString:underlinedString];
    }
    return self;
}

- (void)setupLabelWithRegularString:(NSString *)regularString withUnderlinedString:(NSString *)underlinedString {
    _footerText = [[UILabel alloc] init];
    _footerText.translatesAutoresizingMaskIntoConstraints = NO;
    _footerText.numberOfLines = 0;
    _footerText.textAlignment = NSTextAlignmentCenter;
    _footerText.lineBreakMode = NSLineBreakByWordWrapping;
    _footerText.textColor = UIColorFromRGB(0x7A7A7A);
    _footerText.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    [self addSubview:_footerText];
    
    _footerText.text = regularString;
    [_footerText boldSubstring:underlinedString];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_footerText]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerText)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_footerText]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_footerText)]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
