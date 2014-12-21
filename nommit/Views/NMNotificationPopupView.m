//
//  NMNotificationPopupView.m
//  nommit
//
//  Created by Lucy Guo on 11/7/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMNotificationPopupView.h"

@implementation NMNotificationPopupView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setupContent];
        [self setupCloseButton];
    }
    return self;
}

- (void)setupContent {
    _contentView = [[NMNotificationAskView alloc] initWithFrame:CGRectMake(12.5, 12.5, 259, 372)];
    [self addSubview:_contentView];
}

- (void)setupCloseButton {
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeButton.frame = CGRectMake(0, 0, 26, 26);
    [_closeButton setImage:[UIImage imageNamed:@"PopupClose"] forState:UIControlStateNormal];
    [self addSubview:_closeButton];
}

@end
