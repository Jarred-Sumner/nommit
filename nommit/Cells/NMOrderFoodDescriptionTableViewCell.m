//
//  NMOrderFoodDescriptionTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/28/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMOrderFoodDescriptionTableViewCell.h"

@interface NMOrderFoodDescriptionTableViewCell()<UITextViewDelegate>


@end

@implementation NMOrderFoodDescriptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setupDescriptionLabel];
    [self setupDescriptionField];
    [self setupBorder];
    
    return self;
}

- (void)setupDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:14];
    _descriptionLabel.textColor = UIColorFromRGB(0x5D5D5D);
    _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_descriptionLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionLabel);

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_descriptionLabel]-20-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_descriptionLabel]-5-|" options:0 metrics:nil views:views]];
}

- (void)setupDescriptionField {
    _descriptionField = [[UITextView alloc] init];
    _descriptionField.font = [UIFont fontWithName:@"Avenir" size:14];
    _descriptionField.textColor = UIColorFromRGB(0x5D5D5D);
    _descriptionField.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionField.delegate = self;
    _descriptionField.textContainer.maximumNumberOfLines = 3;
    _descriptionField.textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_descriptionField];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionField);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_descriptionField]-20-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_descriptionField]-5-|" options:0 metrics:nil views:views]];
}

- (void)setupBorder {
    
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = UIColorFromRGB(0xDFDFDF);
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:borderView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
}

#pragma mark - textview delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Enter description here"]) {
        textView.text = @"";
        textView.textColor = UIColorFromRGB(0xDFDFDF); //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Enter description here";
        textView.textColor = UIColorFromRGB(0xDFDFDF); //optional
    }
    [textView resignFirstResponder];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
