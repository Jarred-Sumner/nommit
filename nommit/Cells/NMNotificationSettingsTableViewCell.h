//
//  NMNotificationSettingsTableViewCell.h
//  nommit
//
//  Created by Lucy Guo on 11/20/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMNotificationType) {
    NMNotificationTypePush = 0,
    NMNotificationTypeSMS,
    NMNotificationTypeEmail
};

typedef NS_ENUM(NSInteger, NMNotificationSettingsState) {
    NMNotificationSettingsStateOn = 1,
    NMNotificationSettingsStateOff = 0,
    NMNotificationSettingsStateLoading = -1,
    NMNotificationSettingsStateRequest = 2,
  
};

@interface NMNotificationSettingsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *notificationSwitch;
@property (nonatomic, strong) UIActivityIndicatorView *spinnerView;

@property (nonatomic) NMNotificationSettingsState state;
@property (nonatomic) NMNotificationType type;
@end
