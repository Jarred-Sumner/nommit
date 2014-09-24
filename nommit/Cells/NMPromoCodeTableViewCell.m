//
//  NMPromoCodeTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/23/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMPromoCodeTableViewCell.h"
#import "NMColors.h"

@implementation NMPromoCodeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFBFBFB);
    self.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
    self.layer.borderWidth = 1.0f;
    
    _textField = [[UITextField alloc] init];
    _textField.font = [UIFont fontWithName:@"Avenir" size:16.f];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.delegate = self;
    _textField.placeholder = @"Enter Promo Code";
    
    [self.contentView addSubview:_textField];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_textField);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_textField]-15-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_textField]-0-|" options:0 metrics:nil views:views]];

    
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
