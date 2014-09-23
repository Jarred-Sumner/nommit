//
//  NMLocationTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/22/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMLocationTableViewCell.h"
#import "NMColors.h"

@implementation NMLocationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupNumFood];
    }
    return self;
}

- (void)setupNumFood
{
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"ForkKnife"];
    icon.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:icon];
    
    _numFoodAvailable = [[UILabel alloc] init];
    _numFoodAvailable.text = @"5";
    _numFoodAvailable.textColor = [NMColors mainColor];
    _numFoodAvailable.font = [UIFont fontWithName:@"Avenir" size:16];
    _numFoodAvailable.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_numFoodAvailable];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_numFoodAvailable, icon);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[icon]-5-[_numFoodAvailable]-15-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_numFoodAvailable]-2-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[icon]-10-|" options:0 metrics:nil views:views]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
