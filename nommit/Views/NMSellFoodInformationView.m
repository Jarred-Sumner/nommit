//
//  NMSellFoodInformationView.m
//  nommit
//
//  Created by Lucy Guo on 11/5/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMSellFoodInformationView.h"

@implementation NMSellFoodInformationView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        [self setupBanner];
        [self setupInviteText];
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
    ribbonLabel.text = @"Make $ Selling Food";
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
    inviteLabel.text = @"You can make an average of $20/hr by delivering food with";
    [self addSubview:inviteLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[inviteLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inviteLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[inviteLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(inviteLabel)]];
}

@end
