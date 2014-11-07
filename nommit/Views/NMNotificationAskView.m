//
//  NMNotificationAskView.m
//  nommit
//
//  Created by Lucy Guo on 11/7/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMNotificationAskView.h"
#import "NMColors.h"

@implementation NMNotificationAskView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 2;
        self.backgroundColor = [UIColor whiteColor];
        [self setupBackground];
        [self setupTitle];
        [self setupMessage];
        [self setupButton];
    }
    return self;
}

- (void)setupBackground {
    UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
    background.image = [UIImage imageNamed:@"NotificationPopup"];
    [self addSubview:background];
}

- (void)setupTitle {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [NMColors mainColor];
    titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18];
    titleLabel.text = @"Enable Push Notifications";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:titleLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-186-[titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
}

- (void)setupMessage {
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.textColor = UIColorFromRGB(0x494949);
    _messageLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
    _messageLabel.numberOfLines = 0;
    _messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_messageLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_messageLabel]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_messageLabel)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-247-[_messageLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_messageLabel)]];
}

- (void)setupButton {
    _notifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _notifyButton.layer.cornerRadius = 2;
    _notifyButton.backgroundColor = [NMColors mainColor];
    [_notifyButton setTitle:@"Notify Me!" forState:UIControlStateNormal];
    [_notifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _notifyButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:20.5];
    _notifyButton.frame = CGRectMake(0, self.frame.size.height-54, self.frame.size.width, 54);
    [self addSubview:_notifyButton];
}

@end
