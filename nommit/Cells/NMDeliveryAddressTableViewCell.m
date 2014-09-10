//
//  NMDeliveryAddressTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/10/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryAddressTableViewCell.h"

@interface NMDeliveryAddressTableViewCell() {
    UIImageView *pin;
}

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
    pin = [[UIImageView alloc] init];
    pin.image = [UIImage imageNamed:@"Pin"];
    pin.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:pin];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pin);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[pin]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[pin]" options:0 metrics:nil views:views]];
}

- (void)setupEstimatedTime
{
    _estimatedTime = [[UILabel alloc] init];
    
    _estimatedTime = [[UILabel alloc] init];
    _estimatedTime.font = [UIFont fontWithName:@"Avenir" size:12.0f];
    _estimatedTime.textColor = UIColorFromRGB(0x959595);
    _estimatedTime.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_estimatedTime];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_estimatedTime);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_estimatedTime]-20-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[_estimatedTime]" options:0 metrics:nil views:views]];
}

- (void)setupCurrentAddress
{
    _currentAddress = [[UILabel alloc] init];
    _currentAddress.font = [UIFont fontWithName:@"Avenir" size:15.0f];
    _currentAddress.textColor = UIColorFromRGB(0x4E4E4E);
    _currentAddress.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_currentAddress];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pin, _currentAddress, _estimatedTime);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pin]-20-[_currentAddress]-20-[_estimatedTime]-20-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[_currentAddress]" options:0 metrics:nil views:views]];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
