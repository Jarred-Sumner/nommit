//
//  NMItemInfoView.m
//  nommit
//
//  Created by Lucy Guo on 8/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodInfoCell.h"
#import "NMColors.h"

@implementation NMOrderFoodInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
    self.backgroundView.layer.borderWidth = 1.0f;
    
    [self setupHeaderImageView];
    [self setupNameLabel];
    [self setupDescriptionLabel];
    [self setupPriceLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_headerImageView, _nameLabel, _descriptionLabel, _priceLabel);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headerImageView]-10-[_nameLabel]-10-[_descriptionLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headerImageView]-10-[_priceLabel]" options:0 metrics:nil views:views]];
    return self;
}

#pragma mark - Image View

- (void)setupHeaderImageView {
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = [UIImage imageNamed:@"PepperoniPizza.png"];
    _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:_headerImageView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_headerImageView);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headerImageView]" options:0 metrics:nil views:views]];
}

#pragma mark - Labels

- (void)setupNameLabel {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:22];
    _nameLabel.textColor = UIColorFromRGB(0x3C3C3C);
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupDescriptionLabel {
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:11];
    _descriptionLabel.textColor = UIColorFromRGB(0x5D5D5D);
    _descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_descriptionLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_descriptionLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_descriptionLabel]-15-|" options:0 metrics:nil views:views]];
}

- (void)setupPriceLabel {
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.numberOfLines = 0;
    _priceLabel.font = [UIFont fontWithName:@"Avenir" size:23];
    _priceLabel.textColor = UIColorFromRGB(0x60C4BE);
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_priceLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_priceLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_priceLabel]-15-|" options:0 metrics:nil views:views]];
}

@end
