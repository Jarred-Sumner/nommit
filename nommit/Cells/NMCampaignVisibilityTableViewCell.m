//
//  NMCampaignVisibilityTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/11/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMCampaignVisibilityTableViewCell.h"
#import "NMColors.h"

@interface NMCampaignVisibilityTableViewCell() {
    UILabel *campaignLabel;
}

@end

@implementation NMCampaignVisibilityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [NMColors mainColor];
        [self setupLabel];
        [self setupSwitch];
    }
    return self;
}

- (void)setupLabel
{
    campaignLabel = [[UILabel alloc] init];
    campaignLabel.font = [UIFont fontWithName:@"Avenir" size:25.0f];
    campaignLabel.textColor = [UIColor whiteColor];
    campaignLabel.text = @"Turn On Campaign";
    campaignLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:campaignLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(campaignLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[campaignLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[campaignLabel]-15-|" options:0 metrics:nil views:views]];
}

- (void)setupSwitch
{
    _campaignSwitch = [[UISwitch alloc] init];
    _campaignSwitch.onTintColor = [UIColor whiteColor];
    _campaignSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    _campaignSwitch.tintColor = [UIColor whiteColor];
    [self.contentView addSubview:_campaignSwitch];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_campaignSwitch);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_campaignSwitch]-15-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[_campaignSwitch]-18-|" options:0 metrics:nil views:views]];
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
