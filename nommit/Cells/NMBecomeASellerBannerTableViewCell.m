//
//  NMBecomeASellerBannerTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 1/1/15.
//  Copyright (c) 2015 Lucy Guo. All rights reserved.
//

#import "NMBecomeASellerBannerTableViewCell.h"

@implementation NMBecomeASellerBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BecomeASellerBanner"]];
        backgroundImage.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:backgroundImage];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backgroundImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImage)]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backgroundImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(backgroundImage)]];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
