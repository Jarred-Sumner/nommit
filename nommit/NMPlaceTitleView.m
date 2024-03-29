//
//  NMPlaceTitleView.m
//  nommit
//
//  Created by Jarred Sumner on 1/2/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMPlaceTitleView.h"
#import <FontAwesomeKit.h>

@implementation NMPlaceTitleView

-(id)initWithFrame:(CGRect)frame title:(NSString*)title target:(id)target selector:(SEL)selector {
    self = [self initWithFrame:frame];
    [self setupTitleLabel];
    [self setTitle:title];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [self addGestureRecognizer:tapper];
    
    return self;
}

- (void)setupTitleLabel {
    _titleLabel = [[TTTAttributedLabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_titleLabel];
}

- (void)setTitle:(NSString *)title {
    title = [title stringByAppendingString:@"  "];
    [_titleLabel setText:nil afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        [mutableAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:title]];
        [mutableAttributedString appendAttributedString:[[FAKIonIcons arrowDownBIconWithSize:18.f] attributedString]];
        
        
        NSRange titleRange = [[mutableAttributedString string] rangeOfString:title];
        NSRange arrowRange = [[mutableAttributedString string] rangeOfString:[[FAKIonIcons arrowDownBIconWithSize:12.f] attributedString].string];

        
        UIFont *uiFont = [UIFont fontWithName:@"Avenir-Medium" size:18.f];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)uiFont.fontName, uiFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:titleRange];
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:UIColorFromRGB(0x9C9C9C) range:titleRange];
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:UIColorFromRGB(0x9C9C9C) range:arrowRange];
            
            NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
            [attributes setValue:UIColorFromRGB(0x9C9C9C) forKey:NSForegroundColorAttributeName];
            [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextShadowColor];
            [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0.0, 1.0)] forKey:UITextAttributeTextShadowOffset];
            [attributes setValue:[UIFont fontWithName:@"Avenir-Medium" size:18.0f] forKey:UITextAttributeFont];
            
            [mutableAttributedString setAttributes:attributes range:titleRange];
            
        }
        
        return mutableAttributedString;
    }];
}

@end
