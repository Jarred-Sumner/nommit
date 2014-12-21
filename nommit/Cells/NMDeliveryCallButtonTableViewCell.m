//
//  NMDeliveryCallButtonTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMDeliveryCallButtonTableViewCell.h"
#import "NMColors.h"

@implementation NMDeliveryCallButtonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupCallButton];

    }
    return self;
}

- (void)setupCallButton
{
    // Initialization code
    _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _callButton.backgroundColor = [NMColors mainColor];
    _callButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:24];
    [_callButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _callButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_callButton];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_callButton]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_callButton]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_callButton)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
