//
//  NMDeliveryPlaceHeaderView.m
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryPlaceHeaderView.h"

@interface NMDeliveryPlaceHeaderView ()

@property (nonatomic, copy) NSTimer *refreshTimer;
@property (nonatomic, strong) UIActivityIndicatorView *spinnerView;

@end

@implementation NMDeliveryPlaceHeaderView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupPlaceNumber];
        [self setupPlaceName];
        [self setupArrivalButton];
    }
    return self;
}

#pragma mark - UI Initialization

- (void)setupPlaceNumber {
    UIImageView *whiteCircle = [[UIImageView alloc] init];
    whiteCircle.image = [UIImage imageNamed:@"WhiteCircleSmall"];
    whiteCircle.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:whiteCircle];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[whiteCircle(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(whiteCircle)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[whiteCircle(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(whiteCircle)]];
    
    _placeNumber = [[UILabel alloc] init];
    _placeNumber.font = [UIFont fontWithName:@"Avenir-Black" size:12.0f];
    _placeNumber.textAlignment = NSTextAlignmentCenter;
    _placeNumber.translatesAutoresizingMaskIntoConstraints = NO;
    
    [whiteCircle addSubview:_placeNumber];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_placeNumber]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeNumber)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_placeNumber]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeNumber)]];
    
}

- (void)setupPlaceName {
    _placeName = [[MZTimerLabel alloc] init];
    _placeName.font = [UIFont fontWithName:@"Avenir-Medium" size:14.0f];
    _placeName.textAlignment = NSTextAlignmentRight;
    _placeName.textColor = [UIColor whiteColor];
    _placeName.translatesAutoresizingMaskIntoConstraints = NO;
    [_placeName setTimerType:MZTimerLabelTypeTimer];

    [self.contentView addSubview:_placeName];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_placeName]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeName)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_placeNumber]-10-[_placeName]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_placeName, _placeNumber)]];
}

- (void)setupArrivalButton {
    _arrivalButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrivalButton setBackgroundImage:[UIImage imageNamed:@"ArrivedButton"] forState:UIControlStateNormal];
    _arrivalButton.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:12];
    _arrivalButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_arrivalButton addTarget:self action:@selector(toggleState) forControlEvents:UIControlEventTouchUpInside];
    
    _spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _spinnerView.translatesAutoresizingMaskIntoConstraints = NO;
    _spinnerView.hidden = YES;
    
    [self.contentView addSubview:_arrivalButton];
    [self.contentView addSubview:_spinnerView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_arrivalButton]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_arrivalButton)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_spinnerView]-35-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_spinnerView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-7-[_arrivalButton(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_arrivalButton)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_spinnerView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_spinnerView)]];
}

- (void)setUrgency:(NMDeliveryUrgencyState)urgency {
    
    if (urgency == NMDeliveryUrgencyStateHigh) {
        self.contentView.backgroundColor = UIColorFromRGB(0xB00000);
        _placeNumber.textColor = UIColorFromRGB(0xB00000);
        [_arrivalButton setTitleColor:UIColorFromRGB(0xB00000) forState:UIControlStateNormal];
    } else if (urgency == NMDeliveryUrgencyStateMedium) {
        self.contentView.backgroundColor = UIColorFromRGB(0xE9931E);
        _placeNumber.textColor = UIColorFromRGB(0xE9931E);
        [_arrivalButton setTitleColor:UIColorFromRGB(0xE9931E) forState:UIControlStateNormal];
    } else if (urgency == NMDeliveryUrgencyStateLow) {
        self.contentView.backgroundColor = UIColorFromRGB(0x47DA80);
        _placeNumber.textColor = UIColorFromRGB(0x47DA80);
        [_arrivalButton setTitleColor:UIColorFromRGB(0x47DA80) forState:UIControlStateNormal];
    }
}

- (void)setArrivalState:(NMDeliveryArrivalState)arrival {
    if (arrival == NMDeliveryArrivalStateArrived) {
        [_arrivalButton setTitle:@"I'm Here" forState:UIControlStateNormal];
        _arrivalButton.hidden = NO;
        
        [_spinnerView stopAnimating];
        _spinnerView.hidden = YES;
    } else if (arrival == NMDeliveryArrivalStatePending) {
        [_spinnerView startAnimating];
        _spinnerView.hidden = NO;

        _arrivalButton.hidden = YES;
        
    }
}

#pragma mark - Countdown

- (void)startCountdown {
    [_placeName start];
}

- (void)setEta:(NSDate *)eta {
    if (![eta isEqualToDate:_eta]) {
        [_placeName pause];
        _eta = eta;
        [_placeName setCountDownToDate:_eta];
        [_placeName start];

    }
    
}

- (void)toggleState {
    [self.delegate toggleStateForHeader:self];
}

@end
