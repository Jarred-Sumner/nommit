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
    _deliveryPlace = [[UILabel alloc] init];
    _deliveryPlace.translatesAutoresizingMaskIntoConstraints = NO;
    _deliveryPlace.textColor = UIColorFromRGB(0xC9C9C9);
    _deliveryPlace.textAlignment = NSTextAlignmentCenter;
    _deliveryPlace.lineBreakMode = NSLineBreakByWordWrapping;
    _deliveryPlace.numberOfLines = 0;
    _deliveryPlace.font = [UIFont fontWithName:@"Avenir" size:18];
    [self.contentView addSubview:_deliveryPlace];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_deliveryPlace]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deliveryPlace)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[_deliveryPlace]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deliveryPlace)]];
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
    _statusText = [[UILabel alloc] init];
    _statusText.translatesAutoresizingMaskIntoConstraints = NO;
    _statusText.textColor = UIColorFromRGB(0x696969);
    _statusText.textAlignment = NSTextAlignmentCenter;
    _statusText.lineBreakMode = NSLineBreakByWordWrapping;
    _statusText.numberOfLines = 0;
    _statusText.font = [UIFont fontWithName:@"Avenir" size:26];
    [self.contentView addSubview:_statusText];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_statusText]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusText)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_statusText]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statusText)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
