//
//  NMBecomeASellerApplyTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/1/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMBecomeASellerApplyTableViewCell.h"

@interface NMBecomeASellerApplyTableViewCell()

@property (nonatomic, strong) UIImageView *sellImageLabel;

@end

@implementation NMBecomeASellerApplyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupBG];
        // [self setupBecomeASellerLabel];
        [self setupBecomeASellerImageLabel];
        [self setupApplyButton];
        
    }
    return self;
}

- (void)setupBG {
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BecomeASellerApplyBG"]];
    bg.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:bg];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bg]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bg)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bg]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bg)]];
}

- (void)setupBecomeASellerImageLabel {
    _sellImageLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BecomeASellerLabel"]];
    _sellImageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_sellImageLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-55-[_sellImageLabel(208)]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sellImageLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_sellImageLabel(25)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sellImageLabel)]];
}

- (void)setupBecomeASellerLabel {
    _becomeASellerLabel = [[UILabel alloc] init];
    _becomeASellerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _becomeASellerLabel.font = [UIFont fontWithName:@"SnellRoundhand-Black" size:18];
    _becomeASellerLabel.textColor = UIColorFromRGB(0x525252);
    [self.contentView addSubview:_becomeASellerLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_becomeASellerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_becomeASellerLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_becomeASellerLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_becomeASellerLabel)]];
}

- (void)setupApplyButton {
    _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_applyButton setImage:[UIImage imageNamed:@"BecomeASellerApplyButton"] forState:UIControlStateNormal];
    _applyButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_applyButton];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_applyButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_applyButton)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sellImageLabel(25)]-22-[_applyButton]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sellImageLabel, _applyButton)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
