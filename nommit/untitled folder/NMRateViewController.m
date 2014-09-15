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
    }
    return self;
}

- (void)setupAvatar
{
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 120/2, 70, 120, 120)];
    avatar.layer.cornerRadius = avatar.bounds.size.width/2;
    avatar.layer.masksToBounds = YES;
    avatar.image = [UIImage imageNamed:@"AvatarLucy"];
    [self.view addSubview:avatar];
}

- (void)setupRateLabel:price
{
    rateLabel = [[UILabel alloc] init];
    rateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rateLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:18.0f];
    rateLabel.textColor = UIColorFromRGB(0x4C4C4C);
    if (price  == nil) {
        rateLabel.text = @"Please rate your experience to help our community!";
    } else {
        rateLabel.text = [NSString stringWithFormat:@"Your experience cost $%@. Please rate your experience.", price ];
    }
    rateLabel.textAlignment = NSTextAlignmentCenter;
    rateLabel.numberOfLines = 0;
    rateLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.view addSubview:rateLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(rateLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[rateLabel]-35-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[rateLabel]-100-|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[rateLabel]-50-|" options:0 metrics:nil views:views]];
    }
}

- (void)setupRating
{
    _rateVw = [RateView rateViewWithRating:5.0f];
    _rateVw.starFillMode = StarFillModeHorizontal;
    _rateVw.delegate = self;
    _rateVw.canRate = YES;
    _rateVw.tag = 88888;
    _rateVw.starSize = 50;
    _rateVw.translatesAutoresizingMaskIntoConstraints = NO;
    
    _rateVw.starFillColor = [NMColors mainColor];
    
    
    [self.view addSubview:_rateVw];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rateVw);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[_rateVw]-35-|" options:0 metrics:nil views:views]];
    if (iPhone5)
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-290-[_rateVw]-100-|" options:0 metrics:nil views:views]];
    else
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-270-[_rateVw]-100-|" options:0 metrics:nil views:views]];
    
    UIButton *ratingDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingDoneButton.translatesAutoresizingMaskIntoConstraints = NO;
    [ratingDoneButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"DoneRating"];
    [ratingDoneButton setImage:btnImage forState:UIControlStateNormal];
    ratingDoneButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:ratingDoneButton];
    
    views = NSDictionaryOfVariableBindings(ratingDoneButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[ratingDoneButton]-5-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-380-[ratingDoneButton]-140-|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-360-[ratingDoneButton]-50-|" options:0 metrics:nil views:views]];
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
