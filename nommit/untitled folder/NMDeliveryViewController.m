//
//  NMDeliveryViewController.m
//  nommit
//
//  Created by Lucy Guo on 9/17/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryViewController.h"
#import "NMColors.h"

@interface NMDeliveryViewController ()

@property (nonatomic, strong) NMOrder *order;

@property (nonatomic, strong) UILabel *estimatedLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *placeLabel;

@property (nonatomic, strong) UIImageView *sellerImage;
@property (nonatomic, strong) UIImageView *foodImage;
@property (nonatomic, strong) UIImageView *bannerImage;

@end

@implementation NMDeliveryViewController

- (id)initWithOrder:(NMOrder *)order {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [NMColors lightGray];
        _order = order;
        
        [self setupBanner];
        [self setupSellerImage];
        [self setupFoodImage];
        [self setupETALabels];
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
    _bannerImage = [[UIImageView alloc] init];
    _bannerImage.image = [UIImage imageNamed:@"DeliverBanner"];
    _bannerImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_bannerImage];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_bannerImage);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[_bannerImage]-12-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_bannerImage]" options:0 metrics:nil views:views]];
}

- (void)setupSellerImage
{
    _sellerImage = [[UIImageView alloc] init];
    _sellerImage.layer.cornerRadius = 105 / 2;
    _sellerImage.layer.masksToBounds = YES;
    _sellerImage.translatesAutoresizingMaskIntoConstraints = NO;
    _sellerImage.contentMode = UIViewContentModeScaleAspectFill;
    [_sellerImage setImageWithURL:_order.food.seller.logoAsURL];
    [self.view addSubview:_sellerImage];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-42-[_sellerImage(105)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sellerImage)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[_sellerImage(105)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_sellerImage)]];
}

- (void)setupFoodImage
{
    _foodImage = [[UIImageView alloc] init];
    _foodImage.layer.cornerRadius = 105 / 2;
    _foodImage.layer.masksToBounds = YES;
    _foodImage.contentMode = UIViewContentModeScaleAspectFill;
    _foodImage.translatesAutoresizingMaskIntoConstraints = NO;
    [_foodImage setImageWithURL:_order.food.thumbnailImageAsURL];
    [self.view addSubview:_foodImage];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_foodImage, _sellerImage);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_sellerImage(105)]-26-[_foodImage(105)]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-72-[_foodImage(105)]" options:0 metrics:nil views:views]];
}

- (void)setupETALabels;
{
    _estimatedLabel = [[UILabel alloc] init];
    _estimatedLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _estimatedLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    _estimatedLabel.textColor = UIColorFromRGB(0xC9C9C9);
    _estimatedLabel.text = @"⎯⎯⎯⎯⎯⎯  Estimated Arrival  ⎯⎯⎯⎯⎯⎯";
    _estimatedLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    _estimatedLabel.layer.shadowOffset = CGSizeMake(0, 1);
    _estimatedLabel.textAlignment = NSTextAlignmentCenter;
    _estimatedLabel.numberOfLines = 1;
    [self.view addSubview:_estimatedLabel];

    _timeLabel = [[UILabel alloc] init];
    _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _timeLabel.font = [UIFont fontWithName:@"Avenir" size:44.0f];
    _timeLabel.textColor = UIColorFromRGB(0x666666);
    _timeLabel.text = [self timeLabelText];
    _timeLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    _timeLabel.layer.shadowOffset = CGSizeMake(0, 1);
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.numberOfLines = 1;
    [self.view addSubview:_timeLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_estimatedLabel, _sellerImage, _timeLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[_estimatedLabel]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[_timeLabel]-35-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sellerImage]-20-[_estimatedLabel]-5-[_timeLabel]" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_sellerImage]-10-[_estimatedLabel]-5-[_timeLabel]" options:0 metrics:nil views:views]];
        _timeLabel.font = [UIFont fontWithName:@"Avenir" size:38.0f];
    }
}

- (void)setupRating
{
    UILabel *deliveringToLabel = [[UILabel alloc] init];
    deliveringToLabel.translatesAutoresizingMaskIntoConstraints = NO;
    deliveringToLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.0f];
    deliveringToLabel.textColor = UIColorFromRGB(0xC9C9C9);
    deliveringToLabel.text = @"⎯⎯⎯⎯⎯⎯⎯  Delivering To  ⎯⎯⎯⎯⎯⎯⎯";
    deliveringToLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    deliveringToLabel.layer.shadowOffset = CGSizeMake(0, 1);
    deliveringToLabel.textAlignment = NSTextAlignmentCenter;
    deliveringToLabel.numberOfLines = 1;
    [self.view addSubview:deliveringToLabel];
    
    _placeLabel = [[UILabel alloc] init];
    _placeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _placeLabel.font = [UIFont fontWithName:@"Avenir" size:44.0f];
    _placeLabel.textColor = UIColorFromRGB(0x666666);
    _placeLabel.text = _order.place.name;
    _placeLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
    _placeLabel.layer.shadowOffset = CGSizeMake(0, 1);
    _placeLabel.textAlignment = NSTextAlignmentCenter;
    _placeLabel.numberOfLines = 1;
    [self.view addSubview:_placeLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_placeLabel, deliveringToLabel, _timeLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-35-[_placeLabel]-35-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-25-[deliveringToLabel]-25-|" options:0 metrics:nil views:views]];
    
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timeLabel]-10-[deliveringToLabel]-10-[_placeLabel]-130-|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_timeLabel]-10-[deliveringToLabel]-3-[_placeLabel]-70-|" options:0 metrics:nil views:views]];
    }
}

- (void)setupDoneButton
{
    UIButton *ratingDoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ratingDoneButton.translatesAutoresizingMaskIntoConstraints = NO;
//    [ratingDoneButton addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *btnImage = [UIImage imageNamed:@"RatingDoneButton"];
    [ratingDoneButton setImage:btnImage forState:UIControlStateNormal];
    ratingDoneButton.contentMode = UIViewContentModeScaleToFill;
    
    [self.view addSubview:ratingDoneButton];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(ratingDoneButton);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[ratingDoneButton]-5-|" options:0 metrics:nil views:views]];
    if (iPhone5) {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingDoneButton]-55-|" options:0 metrics:nil views:views]];
    } else {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[ratingDoneButton]-10-|" options:0 metrics:nil views:views]];
    }
    
}

- (NSString *)timeLabelText {
    TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
    timeIntervalFormatter.futureDeicticExpression = @"";
    
    NSString *text = [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:_order.deliveredAt];
    if (!text) text = @"~15 min";
    return text;
}


@end