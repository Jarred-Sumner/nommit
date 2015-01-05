//
//  NMNoFoodTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/4/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMNoFoodTableViewCell.h"
#import <FAKFontAwesome.h>

@interface NMNoFoodTableViewCell()

@property (nonatomic, strong) UIImageView *chef;
@end

@implementation NMNoFoodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xF3F1F1);
        [self setupChefIcon];
        [self setupLabel];
    }
    return self;
}

- (void)setupChefIcon {
    _chef = [[UIImageView alloc] init];
    _chef.translatesAutoresizingMaskIntoConstraints = NO;
    _chef.image = [UIImage imageNamed:@"Chef"];
    _chef.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_chef];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-92-[_chef(135)]-92-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_chef)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[_chef(135)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_chef)]];
}

- (void)setupLabel {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont fontWithName:@"Avenir" size:16];
    label.textColor = UIColorFromRGB(0xB2B2B2);
    
    label.text = @"There's no food available, but you can fix this!";
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 3;
    
    [self.contentView addSubview:label];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-54-[label]-54-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_chef]-20-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label, _chef)]];

    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DownArrow"]];
    arrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.contentView addSubview:arrowImageView];

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-155-[arrowImageView]-155-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(arrowImageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-18-[arrowImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label, arrowImageView)]];
    

}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
