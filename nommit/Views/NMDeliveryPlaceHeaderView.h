//
//  NMDeliveryPlaceHeaderView.h
//  nommit
//
//  Created by Lucy Guo on 10/31/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MZTimerLabel.h>

@class NMDeliveryPlaceHeaderView;

@protocol NMDeliveryPlaceHeaderViewDelegate <NSObject>

@required
- (void)toggleStateForHeader:(NMDeliveryPlaceHeaderView*)header;

@end


typedef NS_ENUM(NSInteger, NMDeliveryUrgencyState) {
    NMDeliveryUrgencyStateHigh = 0,
    NMDeliveryUrgencyStateMedium = 1,
    NMDeliveryUrgencyStateLow = 2
};

typedef NS_ENUM(NSInteger, NMDeliveryArrivalState) {
    NMDeliveryArrivalStatePending = 0,
    NMDeliveryArrivalStateLeaving,
    NMDeliveryArrivalStateArrived
};

@interface NMDeliveryPlaceHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSNumber *index;
@property (nonatomic, strong) UIButton *arrivalButton;
@property (nonatomic, strong) UILabel *placeNumber;
@property (nonatomic, strong) MZTimerLabel *placeName;
@property (nonatomic, strong) NSDate *eta;

@property (nonatomic, weak) NSObject<NMDeliveryPlaceHeaderViewDelegate>*delegate;

- (void)startCountdown;
- (void)setUrgency:(NMDeliveryUrgencyState)urgency;
- (void)setArrivalState:(NMDeliveryArrivalState)arrival;

@end