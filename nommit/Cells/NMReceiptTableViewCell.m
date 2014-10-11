//
//  NMReceiptTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/29/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMReceiptTableViewCell.h"
#import "NMColors.h"

@implementation NMReceiptTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupTip];
        [self setupRating];
    }
    
    return self;
}

- (void)setupTip
{
    UILabel *addTip = [[UILabel alloc] init];
    addTip.translatesAutoresizingMaskIntoConstraints = NO;
    addTip.font = [UIFont fontWithName:@"Avenir" size:18.0f];
    addTip.textColor = UIColorFromRGB(0xC9C9C9);
    addTip.text = @"Your total with tip included is:";
    addTip.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:addTip];
    
    _tipLabel = [[UILabel alloc] init];
    _tipLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _tipLabel.font = [UIFont fontWithName:@"Avenir" size:60];
    _tipLabel.textColor = UIColorFromRGB(0x696969);
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_tipLabel];
    
    _plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_plusButton setImage:[UIImage imageNamed:@"PlusIcon"] forState:UIControlStateNormal];
    _plusButton.contentMode = UIViewContentModeScaleToFill;
    _plusButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_plusButton];
    
    _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minusButton setImage:[UIImage imageNamed:@"MinusIcon"] forState:UIControlStateNormal];
    _minusButton.contentMode = UIViewContentModeScaleToFill;
    _minusButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_minusButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_minusButton,_plusButton, _tipLabel, addTip);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[addTip]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tipLabel]|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[_minusButton]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_plusButton]-30-|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[addTip]-15-[_tipLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addTip]-40-[_plusButton]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addTip]-40-[_minusButton]" options:0 metrics:nil views:views]];


}

- (void)setupRating {
    UILabel *rateDeliveryLabel = [[UILabel alloc] init];
    rateDeliveryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rateDeliveryLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18.0f];
    rateDeliveryLabel.textColor = UIColorFromRGB(0xC9C9C9);
    rateDeliveryLabel.text = @"Rate Your Experience";
    rateDeliveryLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    rateDeliveryLabel.layer.shadowOffset = CGSizeMake(0, 1);
    rateDeliveryLabel.textAlignment = NSTextAlignmentCenter;
    rateDeliveryLabel.numberOfLines = 1;
    [self.contentView addSubview:rateDeliveryLabel];
    
    _rateVw = [NMRateView rateViewWithRating:5.0f];
    _rateVw.starFillMode = StarFillModeHorizontal;
    _rateVw.canRate = YES;
    _rateVw.tag = 88888;
    _rateVw.starSize = 50;
    _rateVw.translatesAutoresizingMaskIntoConstraints = NO;
    
    _rateVw.starFillColor = [NMColors mainColor];
    
    
    [self.contentView addSubview:_rateVw];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw, rateDeliveryLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[_rateVw]-35-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[rateDeliveryLabel]|" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-170-[rateDeliveryLabel]-20-[_rateVw]-30-|" options:0 metrics:nil views:views]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
