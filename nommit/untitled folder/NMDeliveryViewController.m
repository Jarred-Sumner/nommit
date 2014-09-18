//
//  NMDeliveryViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/17/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryViewController.h"
#import "NMColors.h"

@interface NMDeliveryViewController () {
    UILabel *estimatedLabel;
    UILabel *timeLabel;
    UILabel *placeLabel;
    UIImageView *avatar;
    UIImageView *foodAvatar;
    UIImageView *banner;
}

@end

@implementation NMDeliveryViewController

- (id)initWithOrder:(NMOrder *)order {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        [self setupBanner];
        [self setupPersonAvatar];
        [self setupFoodAvatar];
        [self setupestimatedLabel:[NSNumber numberWithInt:12]];
        [self setupRating];
        [self setupDoneButton];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupBanner
{
    banner = [[UIImageView alloc] init];
    banner.image = [UIImage imageNamed:@"DeliverBanner"];
    banner.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:banner];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(banner);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[banner]-12-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[banner]" options:0 metrics:nil views:views]];
}

- (void)setupPersonAvatar
{
    avatar = [[UIImageView alloc] init];
    avatar.layer.cornerRadius = avatar.bounds.size.width/2;
    avatar.layer.masksToBounds = YES;
    avatar.translatesAutoresizingMaskIntoConstraints = NO;
    avatar.image = [UIImage imageNamed:@"AvatarLucySmall"];
    [self.view addSubview:avatar];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-42-[avatar]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(avatar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[avatar]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(avatar)]];
}

- (void)setupFoodAvatar
{
    foodAvatar = [[UIImageView alloc] init];
    foodAvatar.layer.cornerRadius = foodAvatar.bounds.size.width/2;
    foodAvatar.layer.masksToBounds = YES;
    foodAvatar.translatesAutoresizingMaskIntoConstraints = NO;
    foodAvatar.image = [UIImage imageNamed:@"PizzaAvatar"];
    [self.view addSubview:foodAvatar];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(avatar, foodAvatar);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[avatar]-26-[foodAvatar]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[foodAvatar]" options:0 metrics:nil views:views]];
}

- (void)setupestimatedLabel:price
{
    estimatedLabel = [[UILabel alloc] init];
    estimatedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    estimatedLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    estimatedLabel.textColor = UIColorFromRGB(0xC9C9C9);
    estimatedLabel.text = @"⎯⎯⎯⎯⎯⎯  Estimated Arrival  ⎯⎯⎯⎯⎯⎯";
    estimatedLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    estimatedLabel.layer.shadowOffset = CGSizeMake(0, 1);
    estimatedLabel.textAlignment = NSTextAlignmentCenter;
    estimatedLabel.numberOfLines = 1;
    [self.view addSubview:estimatedLabel];
    
    timeLabel = [[UILabel alloc] init];
    timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    timeLabel.font = [UIFont fontWithName:@"Avenir" size:44.0f];
    timeLabel.textColor = UIColorFromRGB(0x666666);
    timeLabel.text = @"3 min";
    timeLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    timeLabel.layer.shadowOffset = CGSizeMake(0, 1);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.numberOfLines = 1;
    [self.view addSubview:timeLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(estimatedLabel, avatar, timeLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[estimatedLabel]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[timeLabel]-35-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[avatar]-20-[estimatedLabel]-5-[timeLabel]" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[avatar]-10-[estimatedLabel]-5-[timeLabel]" options:0 metrics:nil views:views]];
        timeLabel.font = [UIFont fontWithName:@"Avenir" size:38.0f];
    }
}

- (void)setupRating
{
    UILabel *rateDeliveryLabel = [[UILabel alloc] init];
    rateDeliveryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    rateDeliveryLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    rateDeliveryLabel.textColor = UIColorFromRGB(0xC9C9C9);
    rateDeliveryLabel.text = @"⎯⎯⎯⎯⎯⎯⎯  Delivering To  ⎯⎯⎯⎯⎯⎯⎯";
    rateDeliveryLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    rateDeliveryLabel.layer.shadowOffset = CGSizeMake(0, 1);
    rateDeliveryLabel.textAlignment = NSTextAlignmentCenter;
    rateDeliveryLabel.numberOfLines = 1;
    [self.view addSubview:rateDeliveryLabel];
    
    placeLabel = [[UILabel alloc] init];
    placeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    placeLabel.font = [UIFont fontWithName:@"Avenir" size:44.0f];
    placeLabel.textColor = UIColorFromRGB(0x666666);
    placeLabel.text = @"Mudge";
    placeLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    placeLabel.layer.shadowOffset = CGSizeMake(0, 1);
    placeLabel.textAlignment = NSTextAlignmentCenter;
    placeLabel.numberOfLines = 1;
    [self.view addSubview:placeLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(placeLabel, rateDeliveryLabel, timeLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[placeLabel]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[rateDeliveryLabel]-25-|" options:0 metrics:nil views:views]];
    
    if (iPhone5)
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[timeLabel]-10-[rateDeliveryLabel]-10-[placeLabel]-130-|" options:0 metrics:nil views:views]];
    else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[timeLabel]-10-[rateDeliveryLabel]-3-[placeLabel]-70-|" options:0 metrics:nil views:views]];
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
    
    NSDictionary *views = NSDictionaryOfVariableBindings(placeLabel, ratingDoneButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[ratingDoneButton]-5-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingDoneButton]-55-|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingDoneButton]-10-|" options:0 metrics:nil views:views]];
    }
    
}


@end