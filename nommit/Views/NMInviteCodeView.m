//
//  NMInviteCodeView.m
//  nommit
//
//  Created by Lucy Guo on 10/1/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMInviteCodeView.h"
#import "NMColors.h"

@implementation NMInviteCodeView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        [self setupBanner];
        [self setupInviteText];
        [self setupInviteButton];
        [self setupSocialMediaIcons];
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
    ribbonLabel.text = @"Share Nommit";
    ribbonLabel.textColor = [UIColor whiteColor];
    ribbonLabel.font = [UIFont fontWithName:@"Avenir" size:18.0f];
    ribbonLabel.textAlignment = NSTextAlignmentCenter;
    [blankRibbon addSubview:ribbonLabel];
    
    [blankRibbon addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[ribbonLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ribbonLabel)]];
    [blankRibbon addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[ribbonLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ribbonLabel)]];
}

- (void)setupInviteText {
    UILabel *inviteLabel = [[UILabel alloc] init];
    inviteLabel.textColor = UIColorFromRGB(0x5F5F5F);
    inviteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    inviteLabel.textAlignment = NSTextAlignmentCenter;
    inviteLabel.lineBreakMode = NSLineBreakByWordWrapping;
    inviteLabel.numberOfLines = 0;
    inviteLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    inviteLabel.text = @"Help organizations fundraise by inviting friends to Nommit";
    [self addSubview:inviteLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[inviteLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inviteLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[inviteLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inviteLabel)]];
}
- (void)setupInviteButton {
    _inviteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _inviteButton.backgroundColor = [NMColors mainColor];
    _inviteButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [_inviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _inviteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_inviteButton setTitle:@"Invite Friends" forState:UIControlStateNormal];
    
    [self addSubview:_inviteButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_inviteButton]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inviteButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-130-[_inviteButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inviteButton)]];

}

- (void)setupSocialMediaIcons {
    UILabel *inviteLabel = [[UILabel alloc] init];
    inviteLabel.translatesAutoresizingMaskIntoConstraints = NO;
    inviteLabel.text = @"—————— Share Nommit ——————";
    inviteLabel.textColor = UIColorFromRGB(0x454444);
    inviteLabel.textAlignment = NSTextAlignmentCenter;
    inviteLabel.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    [self addSubview:inviteLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[inviteLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inviteLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_inviteButton]-25-[inviteLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inviteButton, inviteLabel)]];
    
    _twitterButton = [self makeInviteButtonWithImage:[UIImage imageNamed:@"InviteTwitter"]];
    [self addSubview:_twitterButton];
    
    _facebookButton = [self makeInviteButtonWithImage:[UIImage imageNamed:@"InviteFacebook"]];
    [self addSubview:_facebookButton];
    
    _messengerButton = [self makeInviteButtonWithImage:[UIImage imageNamed:@"InviteMessenger"]];
    [self addSubview:_messengerButton];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-59-[_facebookButton]-54-[_messengerButton]-54-[_twitterButton]-59-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_twitterButton, _facebookButton, _messengerButton)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[inviteLabel]-20-[_twitterButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_twitterButton, inviteLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[inviteLabel]-20-[_facebookButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_facebookButton, inviteLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[inviteLabel]-20-[_messengerButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_messengerButton, inviteLabel)]];
    
}

- (UIButton *)makeInviteButtonWithImage:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    return button;
}


@end
