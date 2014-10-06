//
//  NMSupportView.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSupportView.h"
#import "NMColors.h"

@interface NMSupportView()

@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation NMSupportView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        [self setupLogo];
        
        [self setupCallButton];
        [self setupTextButton];
        [self setupEmailButton];
        
    }
    return self;
}

- (void)setupLogo {
    _logoView = [[UIImageView alloc] init];
    _logoView.image = [UIImage imageNamed:@"LoginLogo"];
    _logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_logoView];
    
    UILabel *supportLabel = [[UILabel alloc] init];
    supportLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:12.0f];
    supportLabel.textColor = UIColorFromRGB(0x878787);
    supportLabel.textAlignment = NSTextAlignmentCenter;
    supportLabel.lineBreakMode = NSLineBreakByWordWrapping;
    supportLabel.numberOfLines = 0;
    supportLabel.translatesAutoresizingMaskIntoConstraints = NO;
    supportLabel.text = @"Have a problem or question? Contact us to talk.";
    [self addSubview:supportLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-40-[supportLabel]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(supportLabel)]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_logoView]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_logoView]-15-[supportLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoView, supportLabel)]];
}

- (void)setupCallButton {
    _callButton = [self createButtonWithTitle:@"Call Us" withBackgroundColor:[NMColors mainColor]];
    [self addSubview:_callButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_callButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_logoView]-60-[_callButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton, _logoView)]];
}

- (void)setupTextButton {
    _textButton = [self createButtonWithTitle:@"Text Us" withBackgroundColor:UIColorFromRGB(0x009297)];
    [self addSubview:_textButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_textButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_callButton]-10-[_textButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton, _textButton)]];
}

- (void)setupEmailButton {
    _emailButton = [self createButtonWithTitle:@"Email Us" withBackgroundColor:UIColorFromRGB(0x009297)];
    [self addSubview:_emailButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_emailButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emailButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textButton]-10-[_emailButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textButton, _emailButton)]];

}

- (UIButton *)createButtonWithTitle:(NSString *)title withBackgroundColor:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    button.titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

@end
