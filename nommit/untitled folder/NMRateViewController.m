//
//  NMRateViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/11/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMRateViewController.h"
#import "NMColors.h"

@interface NMRateViewController () {
    UILabel *rateLabel;
    UILabel *priceLabel;
    UIImageView *avatar;
}

@end

@implementation NMRateViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (id)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        [self setupAvatar];
        [self setupRateLabel:nil];
        [self setupRating];
    }
    return self;
}

- (id)initWithPrice:(NSString *)price
{
    self = [super init];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        [self setupAvatar];
        [self setupRateLabel:price];
        [self setupRating];
        [self setupDoneButton];
    }
    return self;
}

- (void)setupAvatar
{
    avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 120/2, 60, 120, 120)];
    avatar.layer.cornerRadius = avatar.bounds.size.width/2;
    avatar.layer.masksToBounds = YES;
    avatar.image = [UIImage imageNamed:@"AvatarLucy"];
    [self.view addSubview:avatar];
}

- (void)setupRateLabel:price
{
    rateLabel = [[UILabel alloc] init];
    rateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rateLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    rateLabel.textColor = UIColorFromRGB(0xC9C9C9);
    rateLabel.text = @"⎯⎯⎯⎯⎯⎯  12/24/14 3:12 pm  ⎯⎯⎯⎯⎯⎯";
    rateLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    rateLabel.layer.shadowOffset = CGSizeMake(0, 1);
    rateLabel.textAlignment = NSTextAlignmentCenter;
    rateLabel.numberOfLines = 1;
    [self.view addSubview:rateLabel];
    
    priceLabel = [[UILabel alloc] init];
    priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    priceLabel.font = [UIFont fontWithName:@"Avenir" size:48.0f];
    priceLabel.textColor = UIColorFromRGB(0x666666);
    priceLabel.text = [NSString stringWithFormat:@"$%@", price];
    priceLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    priceLabel.layer.shadowOffset = CGSizeMake(0, 1);
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.numberOfLines = 1;
    [self.view addSubview:priceLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(rateLabel, avatar, priceLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[rateLabel]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[priceLabel]-35-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[avatar]-30-[rateLabel]-15-[priceLabel]" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[avatar]-30-[rateLabel]-10-[priceLabel]" options:0 metrics:nil views:views]];
        priceLabel.font = [UIFont fontWithName:@"Avenir" size:38.0f];
    }
}

- (void)setupRating
{
    UILabel *rateDeliveryLabel = [[UILabel alloc] init];
    rateDeliveryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rateDeliveryLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    rateDeliveryLabel.textColor = UIColorFromRGB(0xC9C9C9);
    rateDeliveryLabel.text = @"⎯⎯⎯⎯⎯⎯  Rate your delivery  ⎯⎯⎯⎯⎯⎯";
    rateDeliveryLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    rateDeliveryLabel.layer.shadowOffset = CGSizeMake(0, 1);
    rateDeliveryLabel.textAlignment = NSTextAlignmentCenter;
    rateDeliveryLabel.numberOfLines = 1;
    [self.view addSubview:rateDeliveryLabel];
    
    _rateVw = [RateView rateViewWithRating:5.0f];
    _rateVw.starFillMode = StarFillModeHorizontal;
    _rateVw.delegate = self;
    _rateVw.canRate = YES;
    _rateVw.tag = 88888;
    _rateVw.starSize = 50;
    _rateVw.translatesAutoresizingMaskIntoConstraints = NO;
    
    _rateVw.starFillColor = [NMColors mainColor];
    
    
    [self.view addSubview:_rateVw];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw, rateDeliveryLabel, priceLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[_rateVw]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[rateDeliveryLabel]-30-|" options:0 metrics:nil views:views]];
    
    if (iPhone5)
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[priceLabel]-15-[rateDeliveryLabel]-25-[_rateVw]-100-|" options:0 metrics:nil views:views]];
    else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[priceLabel]-10-[rateDeliveryLabel]-10-[_rateVw]-100-|" options:0 metrics:nil views:views]];
    }
}

- (void)setupDoneButton
{
    UIButton *ratingDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingDoneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [ratingDoneButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"RatingDoneButton"];
    [ratingDoneButton setImage:btnImage forState:UIControlStateNormal];
    ratingDoneButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:ratingDoneButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw, ratingDoneButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[ratingDoneButton]-5-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingDoneButton]-55-|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingDoneButton]-20-|" options:0 metrics:nil views:views]];
    }

}

#pragma mark
#pragma mark<RateViewDelegate Methods>
#pragma mark

- (void)donePressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [_delegate updateRating:_rateVw.rating];
    [_delegate ratingDoneButtonPressed:sender];
}

-(void)rateView:(RateView*)rateView didUpdateRating:(float)rating
{
    NSLog(@"rateViewDidUpdateRating: %.1f", rating);
    
}

@end
