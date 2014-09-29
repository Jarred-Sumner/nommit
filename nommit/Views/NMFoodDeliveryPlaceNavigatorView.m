//
//  NMFoodDeliveryPlaceNavigator.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMFoodDeliveryPlaceNavigatorView.h"
#import "NMColors.h"

typedef NS_ENUM(NSInteger, NMFoodDeliveryState) {
    NMFoodDeliveryStateOntimeWithDeliveries = 0,
    NMFoodDeliveryStateOntimeWithoutDeliveries = 1,
    NMFoodDeliveryStateLateWithDeliveries = 2,
    NMFoodDeliveryStateLateWithoutDeliveries = 3
};

@interface NMFoodDeliveryPlaceNavigatorView ()

@property (nonatomic, copy) NSTimer *updateTimer;

@property (readonly) NMFoodDeliveryPlace *deliveryPlace;
@property (nonatomic) NMFoodDeliveryState state;

@end

@implementation NMFoodDeliveryPlaceNavigatorView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [NMColors mainColor];
        [self setupNameLabel];
        [self setupNextLabel];
        [self setupArrows];
        
        [self startUpdatingPlaceText];
    }
    return self;
}

- (void)setupNameLabel
{
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont fontWithName:@"Avenir" size:17];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nameLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nameLabel]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_nameLabel]" options:0 metrics:nil views:views]];
}

- (void)setupNextLabel
{
    _nextLabel = [[UILabel alloc] init];
    _nextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _nextLabel.textColor = [UIColor whiteColor];
    _nextLabel.font = [UIFont fontWithName:@"Avenir-LightOblique" size:12];
    _nextLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nextLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_nextLabel, _nameLabel);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_nextLabel]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_nameLabel]-0-[_nextLabel]" options:0 metrics:nil views:views]];
}

- (void)setupArrows
{
    _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightArrow.contentMode = UIViewContentModeScaleAspectFill;
    _rightArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_rightArrow setImage:[UIImage imageNamed:@"RightArrow"] forState:UIControlStateNormal];
    [self addSubview:_rightArrow];
    
    _leftArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftArrow.contentMode = UIViewContentModeScaleAspectFill;
    _leftArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_leftArrow setImage:[UIImage imageNamed:@"LeftArrow"] forState:UIControlStateNormal];
    [self addSubview:_leftArrow];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_rightArrow, _leftArrow);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightArrow]-15-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_leftArrow]" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_rightArrow]-11-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-11-[_leftArrow]-11-|" options:0 metrics:nil views:views]];
    
    [_leftArrow addTarget:self action:@selector(selectPreviousPlace) forControlEvents:UIControlEventTouchUpInside];
    [_rightArrow addTarget:self action:@selector(selectNextPlace) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectPreviousPlace {
    
}

- (void)selectNextPlace {
    
}

- (void)startUpdatingPlaceText {
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateNavigatorState) userInfo:nil repeats:YES];
    [self updateNavigatorState];
}


/* -- Delivery States --
 
 1. "Stay at $placeName for $secondsUntilEta"
 2. "Be at $nextPlaceName in $travelEta"
    - If late,
        - Change to red. "You're late to $placeName. Hurry!"
 3. 

 
*/
- (void)updateNavigatorState {
    
    NSTimeInterval arrivalETA = [self.deliveryPlace.eta timeIntervalSinceNow];

    if (arrivalETA > 0 && self.deliveryPlaces.count > 1) {
        self.state = NMFoodDeliveryStateOntimeWithDeliveries;
    } else if (arrivalETA < 0 && self.deliveryPlaces.count > 1) {
        self.state = NMFoodDeliveryStateLateWithDeliveries;
    } else if (arrivalETA > 0) {
        self.state = NMFoodDeliveryStateOntimeWithoutDeliveries;
    } else {
        self.state = NMFoodDeliveryStateLateWithoutDeliveries;
    }
    
}

- (void)setState:(NMFoodDeliveryState)state {
    _state = state;
    
    _nameLabel.text = self.deliveryPlace.place.name;
    _rightArrow.hidden = NO;
    _leftArrow.hidden = NO;
    
    if (state == NMFoodDeliveryStateLateWithDeliveries) {
        _nameLabel.text = [NSString stringWithFormat:@"You're late!"];
        _nextLabel.text = [NSString stringWithFormat:@"Get to %@ ASAP!", [self.deliveryPlaces[1] place].name];
        self.backgroundColor = UIColorFromRGB(0xE75050);
    } else if (state == NMFoodDeliveryStateLateWithoutDeliveries) {
        _nextLabel.text = @"Shift is over";
        _rightArrow.hidden = YES;
        _leftArrow.hidden = YES;
    } else if (state == NMFoodDeliveryStateOntimeWithDeliveries) {
        NSTimeInterval arrivalETA = [self.deliveryPlace.eta timeIntervalSinceNow];
        int minutes = floor(arrivalETA / 60);
        int seconds = round(arrivalETA - minutes * 60);
        
        NSString *clock = [NSString stringWithFormat:@"%02d:%02d", abs(minutes), abs(seconds)];
        _nextLabel.text = [NSString stringWithFormat:@"Be at %@ in %@", self.deliveryPlaces[1], clock];
    } else if (state == NMFoodDeliveryStateOntimeWithoutDeliveries) {
        _nextLabel.text = @"Last Stop";
        _rightArrow.hidden = YES;
    }

}


- (NMFoodDeliveryPlace*)deliveryPlace {
    return self.deliveryPlaces[0];
}

@end
