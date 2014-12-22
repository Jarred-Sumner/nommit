//
//  NMNotificationPopupView.h
//  nommit
//
//  Created by Lucy Guo on 11/7/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMNotificationAskView.h"

@interface NMNotificationPopupView : UIView

@property (nonatomic, strong) NMNotificationAskView* contentView;
@property (nonatomic, strong) UIButton *closeButton;

@end
