//
//  NMOrderFoodConfirmAddressCell.m
//  nommit
//
//  Created by Jarred Sumner on 9/17/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodConfirmAddressCell.h"

@implementation NMOrderFoodConfirmAddressCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _checkbox = [[M13Checkbox alloc] initWithFrame:CGRectMake(20, 12, CGRectGetWidth(self.contentView.frame) - 40, 24) title:@"Blah blah blah" checkHeight:24];
    _checkbox.checkAlignment = M13CheckboxAlignmentLeft;
    _checkbox.titleLabel.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    _checkbox.titleLabel.textColor = UIColorFromRGB(0x4E4E4E);
    _checkbox.translatesAutoresizingMaskIntoConstraints = NO;
    _checkbox.titleLabel.text = @"This is the correct delivery building";
    _checkbox.strokeColor = [NMColors mainColor];
    _checkbox.checkColor  = [NMColors mainColor];
    
    [self.contentView addSubview:_checkbox];
//    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_checkbox]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_checkbox)]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[_checkbox]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_checkbox)]];
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (selected) [_checkbox setCheckState:M13CheckboxStateChecked];
    else [_checkbox setCheckState:M13CheckboxStateUnchecked];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _checkbox.titleLabel.frame = CGRectInset(_checkbox.titleLabel.frame, 3, 0);
}

@end
