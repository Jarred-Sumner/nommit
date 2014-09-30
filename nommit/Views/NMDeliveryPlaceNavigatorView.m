//
//  NMFoodDeliveryPlaceNavigator.h
//  nommit
//
//  Created by Lucy Guo on 9/24/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMDeliveryPlaceNavigatorView.h"
#import "NMColors.h"

typedef NS_ENUM(NSInteger, NMDeliveryState) {
    NMDeliveryStateOntimeWithDeliveries = 0,
    NMDeliveryStateOntimeWithoutDeliveries = 1,
    NMDeliveryStateLateWithDeliveries = 2,
    NMDeliveryStateLateWithoutDeliveries = 3
};

@interface NMDeliveryPlaceNavigatorView ()

@property (nonatomic, copy) NSTimer *updateTimer;

@property NSInteger index;
@property (readonly) NMDeliveryPlace *deliveryPlace;
@property (nonatomic) NMDeliveryState state;

@end

@implementation NMDeliveryPlaceNavigatorView

- (id)initWithFrame:(CGRect)frame deliveryPlaces:(NSArray*)deliveryPlaces {
    self = [super initWithFrame:frame];
    if (self) {
        _deliveryPlaces = deliveryPlaces;
        self.backgroundColor = [NMColors mainColor];
        [self setupNameLabel];
        [self setupNextLabel];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_nameLabel]-0-[_nextLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameLabel, _nextLabel)]];
        
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
    
    // TODO: Prevent _nameLabel and _nextLabel from overlapping with the arrows when the length of the text is too long.
    // Do this by adding margin, 15px or so, to each side.
    // But, make it work with visual format.
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nameLabel]|" options:0 metrics:nil views:views]];
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
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_nextLabel]|" options:0 metrics:nil views:views]];
}

- (void)setupArrows
{
    _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightArrow.contentMode = UIViewContentModeScaleAspectFill;
    _rightArrow.hidden = YES;
    _rightArrow.translatesAutoresizingMaskIntoConstraints = NO;
    
    [_rightArrow setImage:[UIImage imageNamed:@"RightArrow"] forState:UIControlStateNormal];
    [self addSubview:_rightArrow];
    
    _leftArrow = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftArrow.contentMode = UIViewContentModeScaleAspectFill;
    _leftArrow.hidden = YES;
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
    [self setDeliveryPlaceIndex:_index - 1];
}

- (void)selectNextPlace {
    [self setDeliveryPlaceIndex:_index + 1];
}

- (void)setDeliveryPlaceIndex:(NSInteger)index {
    NSInteger oldIndex = _index;
    if (_index > -1 && _index < _deliveryPlaces.count) {
        _index = index;
        [self updateNavigatorState];
    }
    if (oldIndex != index) [self.delegate didNavigateToDeliveryPlaceAtIndex:index];
}

- (void)startUpdatingPlaceText {
    _updateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateNavigatorState) userInfo:nil repeats:YES];
    [self setDeliveryPlaceIndex:0];
    [self updateNavigatorState];
}

- (void)resetArrows {
    _leftArrow.hidden = NO;
    _rightArrow.hidden = NO;
    
    if (_index == 0) {
        _leftArrow.hidden = YES;
    } else if (_index == _deliveryPlaces.count - 1) {
        _rightArrow.hidden = YES;
    }
}

- (void)updateNavigatorState {
    
    NSTimeInterval arrivalETA = [self.deliveryPlace.arrivesAt timeIntervalSinceNow];
    
    if (arrivalETA > 0 && _index < self.deliveryPlaces.count - 1) {
        self.state = NMDeliveryStateOntimeWithDeliveries;
    } else if (arrivalETA < 0 && _index < self.deliveryPlaces.count - 1) {
        self.state = NMDeliveryStateLateWithDeliveries;
    } else if (arrivalETA > 0) {
        self.state = NMDeliveryStateOntimeWithoutDeliveries;
    } else {
        self.state = NMDeliveryStateLateWithoutDeliveries;
    }
    
}

- (void)setState:(NMDeliveryState)state {
    _state = state;
    _nameLabel.text = self.deliveryPlace.place.name;
    
    NSTimeInterval arrivalETA = [self.deliveryPlace.arrivesAt timeIntervalSinceNow];
    int minutes = floor(arrivalETA / 60);
    int seconds = round(arrivalETA - minutes * 60);
    
    NSString *clock = [NSString stringWithFormat:@"%02d:%02d", abs(minutes), abs(seconds)];
    
    [UIView animateWithDuration:0.1 animations:^{

        if (state == NMDeliveryStateLateWithDeliveries) {
            _nextLabel.text = [NSString stringWithFormat:@"Get to %@, ASAP!", [self.deliveryPlaces[_index + 1] place].name];
            self.backgroundColor = UIColorFromRGB(0xE75050);
        } else if (state == NMDeliveryStateLateWithoutDeliveries) {
            _nextLabel.text = @"Last Stop";
            self.backgroundColor = UIColorFromRGB(0xE75050);
        } else if (state == NMDeliveryStateOntimeWithDeliveries) {
            self.backgroundColor = [NMColors mainColor];
            _nextLabel.text = [NSString stringWithFormat:@"Be at %@ in %@", [self.deliveryPlaces[_index + 1] place].name, clock];
        } else if (state == NMDeliveryStateOntimeWithoutDeliveries) {
            self.backgroundColor = [NMColors mainColor];
            _nextLabel.text = [NSString stringWithFormat:@"Finish Deliveries within %@", clock];
        }
        [self resetArrows];
    }];
 
}


- (NMDeliveryPlace*)deliveryPlace {
    return self.deliveryPlaces[_index];
}

@end
