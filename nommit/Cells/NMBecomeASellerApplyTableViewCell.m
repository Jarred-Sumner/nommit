//
//  NMBecomeASellerApplyTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/1/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMBecomeASellerApplyTableViewCell.h"

@implementation NMBecomeASellerApplyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupBG];
        
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

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
