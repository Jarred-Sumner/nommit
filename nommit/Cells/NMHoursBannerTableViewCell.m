//
//  NMHoursBannerTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 12/18/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMHoursBannerTableViewCell.h"

@interface NMHoursBannerTableViewCell ()

@property (nonatomic, strong) UIImageView *foodAvailableImageView;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation NMHoursBannerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = UIColorFromRGB(0x737373);
        
        _hoursLabel = [[UILabel alloc] init];
        _hoursLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _hoursLabel.textColor = [UIColor whiteColor];
        _hoursLabel.font = [UIFont fontWithName:@"Avenir-BookOblique" size:13];
        _hoursLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_hoursLabel];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_hoursLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_hoursLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_hoursLabel)]];
                        
        
    }
    return self;
}


@end
