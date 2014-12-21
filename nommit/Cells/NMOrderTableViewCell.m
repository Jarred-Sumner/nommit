//
//  NMFoodOrderTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMOrderTableViewCell.h"
#import "NMColors.h"

@interface NMOrderTableViewCell()

@property (nonatomic, strong) UIView *deliveryContainer;

@end

@implementation NMOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupAvatar];
        [self setupName];
        [self setupOrderName];
        [self setupButtons];
        self.state = NMOrderTableViewCellStatePending;
    }
    return self;
}

- (void)setupAvatar
{
    _profileAvatar = [[FBProfilePictureView alloc] initWithFrame:CGRectMake(19.4, 12.375, 45.25, 45.25)];
    _profileAvatar.layer.cornerRadius = CGRectGetWidth(_profileAvatar.bounds) / 2;
    _profileAvatar.contentMode = UIViewContentModeScaleAspectFit;
    _profileAvatar.layer.masksToBounds = YES;
    [self.contentView addSubview:_profileAvatar];
}

- (void)setupName
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    _nameLabel.textColor = UIColorFromRGB(0x3C3C3C);
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-70-[_nameLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-14-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupOrderName
{
    _orderName = [[UILabel alloc] init];
    _orderName.numberOfLines = 1;
    _orderName.font = [UIFont fontWithName:@"Avenir-Light" size:13];
    _orderName.textColor = UIColorFromRGB(0x3C3C3C);
    _orderName.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_orderName];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_orderName, _nameLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-70-[_orderName(150)]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-0-[_orderName]" options:0 metrics:nil views:views]];
}

- (void)setupButtons
{
    _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _callButton.contentMode = UIViewContentModeScaleAspectFill;
    _callButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_callButton setImage:[UIImage imageNamed:@"PhoneIcon"] forState:UIControlStateNormal];
    [self.contentView addSubview:_callButton];
    
    _deliveryContainer = [[UIView alloc] init];
    _deliveryContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_deliveryContainer];
    
    _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneButton.contentMode = UIViewContentModeScaleAspectFill;
    _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_doneButton setImage:[UIImage imageNamed:@"CheckMarkIcon"] forState:UIControlStateNormal];
    [_deliveryContainer addSubview:_doneButton];
    
    _spinnerView = [[UIActivityIndicatorView alloc] init];
    _spinnerView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _spinnerView.color = [NMColors mainColor];
    _spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    [_deliveryContainer addSubview:_spinnerView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_callButton, _spinnerView, _deliveryContainer, _doneButton);
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_callButton(40)]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_callButton(40)]-5-[_deliveryContainer(40)]-13-|" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_deliveryContainer(40)]" options:0 metrics:nil views:views]];
    
    [_deliveryContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_doneButton(40)]|" options:0 metrics:nil views:views]];
    [_deliveryContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_doneButton(40)]|" options:0 metrics:nil views:views]];
    [_deliveryContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_spinnerView(40)]|" options:0 metrics:nil views:views]];
    [_deliveryContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_spinnerView(40)]|" options:0 metrics:nil views:views]];

}

- (void)setState:(NMOrderTableViewCellState)state {
    [UIView animateWithDuration:0.15 animations:^{

        if (state == NMOrderTableViewCellStateDelivering) {
            [self.spinnerView startAnimating];
            self.spinnerView.hidden = NO;
            self.doneButton.hidden = YES;
        } else {
            [self.spinnerView stopAnimating];
            self.spinnerView.hidden = YES;
            self.doneButton.hidden = NO;
        }

    }];
}

@end
