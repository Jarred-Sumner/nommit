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
    }
    return self;
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
    
    [_bgView addSubview:_notificationSwitch];
    
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_notificationSwitch]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_notificationSwitch)]];
    [_bgView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_notificationSwitch]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_notificationSwitch)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
