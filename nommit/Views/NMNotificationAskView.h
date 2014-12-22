//
//  NMNotificationAskView.h
//  nommit
//
//  Created by Lucy Guo on 11/7/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

@interface NMNotificationAskView : UIView

@property (nonatomic, strong) TTTAttributedLabel *messageLabel;
@property (nonatomic, strong) UIButton *notifyButton;

@end
