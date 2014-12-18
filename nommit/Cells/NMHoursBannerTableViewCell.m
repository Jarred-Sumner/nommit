//
//  NMHoursBannerTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 12/18/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMHoursBannerTableViewCell.h"

@implementation NMHoursBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bannerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HoursBanner"]];
        bannerImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:bannerImage];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bannerImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bannerImage)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bannerImage]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bannerImage)]];
        
        [self setupHoursLabel];
        
    }
    return self;
}

- (void)setupHoursLabel {
    _hoursLabel = [[UILabel alloc] init];
    _hoursLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _hoursLabel.font = [UIFont fontWithName:@"Avenir" size:15.0];
    _hoursLabel.textColor = [UIColor whiteColor];
    _hoursLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_hoursLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_hoursLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_hoursLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
