//
//  NMYourCardsTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/25/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMPaymentMethodTableViewCell.h"

@implementation NMPaymentMethodTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorFromRGB(0xFBFBFB);
        
        [self setupCardView];
        [self setupCardImage];
        [self setupCardLabel];
    }
    return self;
}

- (void)setupCardView
{
    UIView *cardView = [[UIView alloc] init];
    cardView.backgroundColor = [UIColor whiteColor];
    cardView.layer.borderColor = [UIColorFromRGB(0xE9E9E9) CGColor];
    cardView.layer.borderWidth = 1.0f;
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:cardView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[cardView]-24-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cardView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-22-[cardView]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(cardView)]];
}

- (void)setupCardImage
{
    _cardImage = [[UIImageView alloc] init];
    _cardImage.translatesAutoresizingMaskIntoConstraints = NO;
    _cardImage.image = [UIImage imageNamed:@"visa"];
    [self.contentView addSubview:_cardImage];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-34-[_cardImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cardImage)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[_cardImage]-12-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cardImage)]];
}

- (void)setupCardLabel
{
    _cardLabel = [[UILabel alloc] init];
    _cardLabel.textColor = UIColorFromRGB(0x474747);
    _cardLabel.font = [UIFont fontWithName:@"Avenir" size:15];
    _cardLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    [self.contentView addSubview:_cardLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_cardImage]-10-[_cardLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cardImage, _cardLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_cardLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_cardLabel)]];
    
}


@end
