//
//  NMDeliveryCountdownTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryCountdownTableViewCell.h"
#import "NMColors.h"

@implementation NMDeliveryCountdownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentView.layer.masksToBounds = NO;
    self.layer.masksToBounds = NO;
    
    [self setupDeliveryPlace];
    [self setupTimerLabel];
    [self setupStatusText];
    
    return self;
}

- (void)setupDeliveryPlace
{
    _deliveryPlaceLabel = [[UILabel alloc] init];
    _deliveryPlaceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _deliveryPlaceLabel.textColor = UIColorFromRGB(0xC9C9C9);
    _deliveryPlaceLabel.textAlignment = NSTextAlignmentCenter;
    _deliveryPlaceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _deliveryPlaceLabel.numberOfLines = 0;
    _deliveryPlaceLabel.font = [UIFont fontWithName:@"Avenir" size:18];
    [self.contentView addSubview:_deliveryPlaceLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_deliveryPlaceLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deliveryPlaceLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-42-[_deliveryPlaceLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deliveryPlaceLabel)]];
}

- (void)setupTimerLabel
{
    _timerLabel = [[MZTimerLabel alloc] init];
    _timerLabel.timeLabel.font = [UIFont fontWithName:@"Avenir" size:50];
    _timerLabel.timeLabel.textColor = UIColorFromRGB(0x696969);
    _timerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.timeFormat = @"mm:ss";
    _timerLabel.timerType = MZTimerLabelTypeTimer;
    [self.contentView addSubview:_timerLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_timerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timerLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timerLabel]-35-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_timerLabel)]];
}

- (void)setupStatusText
{
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _statusLabel.textColor = UIColorFromRGB(0x696969);
    _statusLabel.textAlignment = NSTextAlignmentCenter;
    _statusLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _statusLabel.numberOfLines = 0;
    _statusLabel.font = [UIFont fontWithName:@"Avenir" size:26];
    [self.contentView addSubview:_statusLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_statusLabel]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_statusLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusLabel)]];
}

- (void)setState:(NMDeliveryCountdownState)state {
    _state = state;
    __block NMDeliveryCountdownTableViewCell *this = self;
    if (state == NMDeliveryCountdownStateArrived) {
        self.timerLabel.hidden = YES;
        [self.timerLabel pause];
        self.statusLabel.hidden = NO;
        self.statusLabel.text = @"Waiting in the lobby.";
    } else if (state == NMDeliveryCountdownStateArrivingSoon) {
        self.timerLabel.hidden = YES;
        [self.timerLabel pause];
        self.statusLabel.hidden = NO;
        self.statusLabel.text = @"Arriving Now";
    } else if (state == NMDeliveryCountdownStateCounting) {
        self.timerLabel.hidden = NO;
        self.statusLabel.hidden = YES;
        [self.timerLabel startWithEndingBlock:^(NSTimeInterval countTime) {
            this.state = NMDeliveryCountdownStateArrivingSoon;
        }];
        
    }
}

- (void)setArrivalEstimate:(NSDate *)arrivalEstimate {
    if (![arrivalEstimate isEqualToDate:_arrivalEstimate]) {
        [self.timerLabel setCountDownToDate:arrivalEstimate];
        _arrivalEstimate = arrivalEstimate;
        
        if ([arrivalEstimate timeIntervalSinceNow] > 0) {
            self.state = NMDeliveryCountdownStateCounting;
        } else {
            self.state = NMDeliveryCountdownStateArrivingSoon;
        }
    }
}


@end
