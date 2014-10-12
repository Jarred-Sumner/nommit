//
//  NMOrderFoodDescriptionTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/28/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodDescriptionTableViewCell.h"

@implementation NMOrderFoodDescriptionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self setupDescriptionLabel];
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

- (void)setupBorder {
    
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = UIColorFromRGB(0xDFDFDF);
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:borderView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
