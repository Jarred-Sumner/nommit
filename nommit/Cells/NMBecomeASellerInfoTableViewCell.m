//
//  NMBecomeASellerInfoTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/1/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMBecomeASellerInfoTableViewCell.h"

@interface NMBecomeASellerInfoTableViewCell ()

@property (nonatomic, strong) UIImageView *icons;

@end

@implementation NMBecomeASellerInfoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xF3F1F1);
        [self setupIcons];
        [self setupTitles];
        [self setupDescriptions];
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupIcons {
    _icons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BecomeASellerIcons"]];
    _icons.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_icons];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-28-[_icons]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_icons)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_icons(228)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_icons)]];
    
}

- (void)setupTitles {
    _dollarTitle = [self setupTitleLabelWithColor:UIColorFromRGB(0x9013FE)];
    _chefTitle = [self setupTitleLabelWithColor:UIColorFromRGB(0x50E3C2)];
    _peopleTitle = [self setupTitleLabelWithColor:UIColorFromRGB(0xFF0000)];
    
    [self.contentView addSubview:_dollarTitle];
    [self.contentView addSubview:_chefTitle];
    [self.contentView addSubview:_peopleTitle];
}

- (void)setupDescriptions {
    _dollarDesc = [self descriptionLabel];
    _chefDesc = [self descriptionLabel];
    _peopleDesc = [self descriptionLabel];
    
    [self.contentView addSubview:_dollarDesc];
    [self.contentView addSubview:_chefDesc];
    [self.contentView addSubview:_peopleDesc];
}

- (void)setupConstraints {
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_icons, _dollarTitle, _dollarDesc, _chefDesc, _chefTitle, _peopleTitle, _peopleDesc);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icons]-11-[_dollarTitle]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icons]-11-[_chefTitle]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icons]-11-[_peopleTitle]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icons]-11-[_dollarDesc]-29-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icons]-11-[_chefDesc]-29-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icons(60)]-11-[_peopleDesc]-29-|" options:0 metrics:nil views:views]];
    

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_dollarTitle]-1-[_dollarDesc]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-118-[_chefTitle]-1-[_chefDesc]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-203-[_peopleTitle]-1-[_peopleDesc]" options:0 metrics:nil views:views]];
    
}

- (UILabel *)setupTitleLabelWithColor:(UIColor *)color {
    UILabel *title = [[UILabel alloc] init];
    title.translatesAutoresizingMaskIntoConstraints = NO;
    title.font = [UIFont fontWithName:@"Avenir-Medium" size:11.5];
    title.textColor = color;
    
    return title;
}

- (UILabel *)descriptionLabel {
    UILabel *descriptionLabel = [[UILabel alloc] init];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionLabel.font = [UIFont fontWithName:@"Avenir" size:10];
    descriptionLabel.textColor = UIColorFromRGB(0x7A7A7A);
    descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLabel.numberOfLines = 0;
    
    return descriptionLabel;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
