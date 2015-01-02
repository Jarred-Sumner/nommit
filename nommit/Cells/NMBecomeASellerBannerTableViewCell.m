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
        
        [self setupLabel];
        
    }
    return self;
}

- (void)setupLabel {
    _bannerLabel = [[UILabel alloc] init];
    _bannerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _bannerLabel.font = [UIFont fontWithName:@"Avenir" size:13];
    _bannerLabel.textColor = [UIColor whiteColor];
    _bannerLabel.numberOfLines = 0;
    _bannerLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _bannerLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_bannerLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-29-[_bannerLabel]-29-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bannerLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bannerLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bannerLabel)]];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
