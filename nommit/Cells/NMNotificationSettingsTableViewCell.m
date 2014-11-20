//
//  NMNotificationSettingsTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 11/20/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMNotificationSettingsTableViewCell.h"
#import "NMColors.h"

@interface NMNotificationSettingsTableViewCell()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) NSString *text;


@end

@implementation NMNotificationSettingsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        [self setupBackgroundView];
        [self setupTitleLabel];
        [self setupSwitch];
        [self setupSpinnerView];
        
        self.state = NMNotificationSettingsStateLoading;
    }
    return self;
}

- (void)setState:(NMNotificationSettingsState)state {
    _state = state;
    
    if (state == NMNotificationSettingsStateLoading) {
        self.notificationSwitch.hidden = YES;
        
        [self.spinnerView startAnimating];
        self.spinnerView.hidden = NO;
        
        self.titleLabel.text = @"Loading...";
    } else if (state == NMNotificationSettingsStateOn) {
        [self.spinnerView stopAnimating];
        self.spinnerView.hidden = YES;
        
        self.titleLabel.text = [NSString stringWithFormat:@"Disable %@", _text];
        self.notificationSwitch.hidden = NO;
        self.notificationSwitch.on = YES;
    } else if (state == NMNotificationSettingsStateOff) {
        [self.spinnerView stopAnimating];
        self.spinnerView.hidden = YES;
        
        self.titleLabel.text = [NSString stringWithFormat:@"Enable %@", _text];
        self.notificationSwitch.hidden = NO;
        self.notificationSwitch.on = NO;
    } else if (state == NMNotificationSettingsStateRequest) {
        [self.spinnerView stopAnimating];
        self.spinnerView.hidden = YES;
        
        self.titleLabel.text = [NSString stringWithFormat:@"Request %@", _text];
        self.notificationSwitch.hidden = YES;
    }
    

}

- (void)setType:(NMNotificationType)type {
    _type = type;
    if (type == NMNotificationTypeEmail) {
        _text = @"Email Notifications";
    } else if (type == NMNotificationTypePush) {
        _text = @"Push Notifications";
    } else if (type == NMNotificationTypeSMS) {
        _text = @"Text Notifications";
    }
}

- (void)setupBackgroundView {
    _bgView = [[UIView alloc] init];
    _bgView.translatesAutoresizingMaskIntoConstraints = NO;
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.borderColor = [UIColorFromRGB(0xF1F1F1) CGColor];
    _bgView.layer.borderWidth = 1.0f;
    
    [self.contentView addSubview:_bgView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_bgView]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[_bgView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgView)]];

}

- (void)setupTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont fontWithName:@"Avenir" size:12.5f];
    _titleLabel.textColor = UIColorFromRGB(0x363636);
    [_bgView addSubview:_titleLabel];
    
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
}

- (void)setupSwitch {
    _notificationSwitch = [[UISwitch alloc] init];
    _notificationSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    _notificationSwitch.onTintColor = [NMColors mainColor];
    _notificationSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75);
    _notificationSwitch.userInteractionEnabled = NO;
    
    [_bgView addSubview:_notificationSwitch];
    
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_notificationSwitch]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_notificationSwitch)]];
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_notificationSwitch]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_notificationSwitch)]];
}

- (void)setupSpinnerView {
    _spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    _spinnerView.tintColor = [NMColors mainColor];
    _spinnerView.transform = CGAffineTransformMakeScale(0.75, 0.75);
    [_bgView addSubview:_spinnerView];
    
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_spinnerView]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_spinnerView)]];
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_spinnerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_spinnerView)]];
}

@end
