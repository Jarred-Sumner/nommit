//
//  NMAccountPromoTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMAccountPromoTableViewCell.h"

@implementation NMAccountPromoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = UIColorFromRGB(0xFBFBFB);
    
    [self setupTextField];
    [self setupSubmitButton];
    [self setupCreditLabel];
    [self setupConstraints];
    
    
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
    _textField.placeholder = @"Enter Promo Code";
    _textField.layer.borderWidth = 1.0f;
    _textField.layer.borderColor = [UIColorFromRGB(0xE9E9E9) CGColor];
    _textField.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_textField];
}

- (void)setupSubmitButton
{
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _submitButton.layer.cornerRadius = 2;
    _submitButton.backgroundColor = UIColorFromRGB(0x7C7C7C);
    [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:12];
    _submitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_submitButton];
}

- (void)setupCreditLabel
{
    _creditLabel = [[UILabel alloc] init];
    _creditLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _creditLabel.font = [UIFont fontWithName:@"Avenir" size:12.5f];
    _creditLabel.textColor = UIColorFromRGB(0x616161);
    _creditLabel.textAlignment = NSTextAlignmentCenter;
    _creditLabel.numberOfLines = 0;
    _creditLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [self.contentView addSubview:_creditLabel];
}

- (void)setupConstraints
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_textField, _submitButton, _creditLabel);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[_textField]-90-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_textField]-6-[_submitButton]-24-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[_textField]-20-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_submitButton]-22-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_creditLabel]-30-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textField]-10-[_creditLabel]" options:0 metrics:nil views:views]];
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
    [aTextField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *invalidCharSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqsrtuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:invalidCharSet] componentsJoinedByString:@""];
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
