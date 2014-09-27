//
//  NMRegisterPhoneTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/26/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRegisterPhoneTableViewCell.h"
#import "AKNumericFormatter.h"
#import "UITextField+AKNumericFormatter.h"

@implementation NMRegisterPhoneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        [self setupTextField];
    }
    return self;
}

- (void)setupTextField
{
    _textField = [[NMPromoTextField alloc] init];
    _textField.font = [UIFont fontWithName:@"Avenir" size:16.f];
    _textField.translatesAutoresizingMaskIntoConstraints = NO;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.delegate = self;
    _textField.placeholder = @"(XXX) XXX-XXXX";
    _textField.layer.borderWidth = 1.0f;
    _textField.layer.borderColor = [UIColorFromRGB(0xE9E9E9) CGColor];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.numericFormatter = [AKNumericFormatter formatterWithMask:@"(***) ***-****"
                                                       placeholderCharacter:'*'];
    [self.contentView addSubview:_textField];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_textField]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[_textField]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textField)]];}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqsrtuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
    [_delegate checkPhoneValid];
    return [string isEqualToString:filtered];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
