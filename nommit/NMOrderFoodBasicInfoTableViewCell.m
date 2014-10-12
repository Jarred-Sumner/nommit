//
//  NMOrderFoodBasicInfoTableViewCell.m
//  nommit
//
//  Created by Lucy Guo on 9/28/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMOrderFoodBasicInfoTableViewCell.h"
#import "NMColors.h"

@implementation NMOrderFoodBasicInfoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = UIColorFromRGB(0xFBFBFB);

    self.contentView.layer.masksToBounds = NO;
    self.layer.masksToBounds = NO;
    
    [self setupAvatar];
    [self setupNameLabel];
    [self setupPriceLabel];
    
    // NEW STUFF
    [self setupDigitInput];
    [self addBorder];
    
    return self;
}

#pragma mark - Avatar Image View
- (void)setupAvatar
{
    _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(16, -35, 80, 80)];
    _avatar.layer.cornerRadius = 80 / 2;
    _avatar.layer.masksToBounds = YES;
    _avatar.contentMode = UIViewContentModeScaleAspectFill;
    _avatar.image = [UIImage imageNamed:@"LoadingSeller"];
    
    UIImageView *avatarBorder = [[UIImageView alloc] initWithFrame:CGRectMake(11, -39, 90, 90)];
    avatarBorder.image = [UIImage imageNamed:@"AvatarBorder"];
    
    [self.contentView addSubview:_avatar];
    [self.contentView addSubview:avatarBorder];
}


#pragma mark - Labels

- (void)setupNameLabel {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.numberOfLines = 1;
    _nameLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12];
    _nameLabel.textColor = UIColorFromRGB(0x7B7B7B);
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-106-[_nameLabel(<=230)]" options:0 metrics:nil views:views]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupPriceLabel {
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.numberOfLines = 1;
    _priceLabel.font = [UIFont fontWithName:@"Avenir" size:18.5];
    _priceLabel.textColor = UIColorFromRGB(0x60C4BE);
    _priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _priceLabel.lineBreakMode = NSLineBreakByClipping;
    
    [self.contentView addSubview:_priceLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_priceLabel, _nameLabel);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-5-[_priceLabel]" options:0 metrics:nil views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-106-[_priceLabel]-150-|" options:0 metrics:nil views:views]];
    
}

- (void)addBorder
{
    UIView *borderView = [[UIView alloc] init];
    borderView.backgroundColor = UIColorFromRGB(0xDFDFDF);
    borderView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:borderView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderView(1)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderView)]];
}

- (void)setupDigitInput
{
    UILabel *quantityLabel = [[UILabel alloc] init];
    quantityLabel.translatesAutoresizingMaskIntoConstraints = NO;
    quantityLabel.textColor = UIColorFromRGB(0xBCBCBC);
    quantityLabel.font = [UIFont fontWithName:@"Avenir" size:11.0f];
    quantityLabel.text = @"QTY";
    quantityLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:quantityLabel];
    
    _quantityInput = [[CHDigitInput alloc] initWithNumberOfDigits:1];
    _quantityInput.translatesAutoresizingMaskIntoConstraints = NO;
    
    _quantityInput.digitBackgroundImage = [UIImage imageNamed:@"DigitOverlay2"];
    
    _quantityInput.placeHolderCharacter = @"1";
    
    _quantityInput.digitViewBackgroundColor = [UIColor clearColor];
    _quantityInput.digitViewHighlightedBackgroundColor = [UIColor clearColor];
    
    _quantityInput.digitViewTextColor = UIColorFromRGB(0x4A4A4A);
    _quantityInput.digitViewHighlightedTextColor = UIColorFromRGB(0x42B7BB);
    _quantityInput.digitViewFont = [UIFont fontWithName:@"Avenir" size:18.0f];
    _quantityInput.digitPadding = 13.5f;
    
    
    // we changed the default settings, so call redrawControl
    [_quantityInput redrawControl];
    
    [self.contentView addSubview:_quantityInput];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_quantityInput, quantityLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_quantityInput(50)]-16-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[quantityLabel]-30-|" options:0 metrics:nil views:views ]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[quantityLabel]-0-[_quantityInput]-7-|" options:0 metrics:nil views:views ]];
    
    // adding the target,actions for available events
    [_quantityInput addTarget:_delegate action:@selector(quantityDidChange) forControlEvents:UIControlEventValueChanged];
}

// dismissing the keyboard
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_quantityInput resignFirstResponder];
}

@end
