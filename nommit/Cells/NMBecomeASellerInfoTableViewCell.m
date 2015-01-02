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
        self.backgroundColor = UIColorFromRGB(0xF3F1F1);
        [self setupIcons];
        
    }
    return self;
}

- (void)setupIcons {
    _icons = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BecomeASellerIcons"]];
    _icons.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_icons];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-28-[_icons]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_icons)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[_icons]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_icons)]];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
