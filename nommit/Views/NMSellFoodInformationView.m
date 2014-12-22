//
//  NMSellFoodInformationView.m
//  nommit
//
//  Created by Lucy Guo on 11/5/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMSellFoodInformationView.h"

@interface NMSellFoodInformationView()

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *inviteLabel;

@end

@implementation NMSellFoodInformationView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        [self setupBanner];
        [self setupInviteText];
        [self setupLogo];
        [self setupEmailButton];
    }
    return self;
}

- (void)setupBanner {
    UIImageView *blankRibbon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlankRibbon"]];
    blankRibbon.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:blankRibbon];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(blankRibbon);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[blankRibbon]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[blankRibbon]" options:0 metrics:nil views:views]];
    
    UILabel *ribbonLabel = [[UILabel alloc] init];
    ribbonLabel.translatesAutoresizingMaskIntoConstraints = NO;
    ribbonLabel.text = @"Fundraise with Nommit";
    ribbonLabel.textColor = [UIColor whiteColor];
    ribbonLabel.font = [UIFont fontWithName:@"Avenir" size:18.0f];
    ribbonLabel.textAlignment = NSTextAlignmentCenter;
    [blankRibbon addSubview:ribbonLabel];
    
    [blankRibbon addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ribbonLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ribbonLabel)]];
    [blankRibbon addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ribbonLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ribbonLabel)]];
}

- (void)setupInviteText {
    _inviteLabel = [[UILabel alloc] init];
    _inviteLabel.textColor = UIColorFromRGB(0x5F5F5F);
    _inviteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _inviteLabel.textAlignment = NSTextAlignmentCenter;
    _inviteLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _inviteLabel.numberOfLines = 0;
    _inviteLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    _inviteLabel.text = @"Organizations have raised thousands of dollars fundraising with Nommit.";
    [self addSubview:_inviteLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_inviteLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inviteLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_inviteLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inviteLabel)]];
}

- (void)setupLogo {
    _logoView = [[UIImageView alloc] init];
    _logoView.image = [UIImage imageNamed:@"LoginLogo"];
    _logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_logoView];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-50-[_logoView]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_inviteLabel]-15-[_logoView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoView, _inviteLabel)]];
}

- (void)setupEmailButton {
    _emailButton = [self createButtonWithTitle:@"Email us to learn more" withBackgroundColor:UIColorFromRGB(0x818181)];
    [self addSubview:_emailButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_emailButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_emailButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_logoView]-25-[_emailButton(44)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_logoView, _emailButton)]];
    
}

- (UIButton *)createButtonWithTitle:(NSString *)title withBackgroundColor:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    button.titleLabel.font = [UIFont fontWithName:@"Avenir" size:18];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

@end
