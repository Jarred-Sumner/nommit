//
//  NMDeliveryPlaceHeaderView.h
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NMDeliveryUrgency) {
    NMDeliveryUrgencyHigh = 0,
    NMDeliveryUrgencyMed = 1,
    NMDeliveryUrgencyLow = 2
};

@interface NMDeliveryPlaceHeaderView : UIView

@property (nonatomic, strong) UILabel *placeNumber;
@property (nonatomic, strong) UILabel *placeName;
@property (nonatomic, strong) UILabel *placeTime;
@property (nonatomic, strong) UIButton *arrivalButton;

- (void)setUrgency:(NMDeliveryUrgency)urgency;

@end
