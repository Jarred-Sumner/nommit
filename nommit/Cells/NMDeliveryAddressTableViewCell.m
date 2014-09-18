//
//  NMDeliveryAddressTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryAddressTableViewCell.h"

@interface NMDeliveryAddressTableViewCell()

@property (nonatomic, strong) UIImageView *pin;

@end

@implementation NMDeliveryAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
                
        self.layer.borderColor = [UIColorFromRGB(0xD3D3D3) CGColor];
        self.layer.borderWidth = 1.0f;
        
        [self setupPin];
        [self setupEstimatedTime];
        [self setupCurrentAddress];
    }
    return self;
}

- (void)setupPin
{
    _pin = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pin"]];
    _pin.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_pin];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_pin);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_pin]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[_pin]" options:0 metrics:nil views:views]];
}

- (void)setupEstimatedTime
{
    _estimatedTimeLabel = [[UILabel alloc] init];
    _estimatedTimeLabel.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _estimatedTimeLabel.textColor = UIColorFromRGB(0x959595);
    _estimatedTimeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_estimatedTimeLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_estimatedTimeLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_estimatedTimeLabel]-20-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[_estimatedTimeLabel]" options:0 metrics:nil views:views]];
}

- (void)setupCurrentAddress
{
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    _addressLabel.textColor = UIColorFromRGB(0x4E4E4E);
    _addressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _addressLabel.text = @"Enter an Address";
    
    [self.contentView addSubview:_addressLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_pin, _addressLabel, _estimatedTimeLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_pin]-20-[_addressLabel]-20-[_estimatedTimeLabel]-20-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[_addressLabel]" options:0 metrics:nil views:views]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
