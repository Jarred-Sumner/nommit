//
//  NMRateView.h
//  nommit
//
//  Created by Jarred Sumner on 10/11/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "RateView.h"

typedef NS_ENUM(NSInteger, NMRateViewState) {
    NMRateViewStateEnded = 0,
    NMRateViewStateStarted = 1
};

@protocol NMRateViewDelegate <NSObject>

@optional
-(void)rateView:(RateView*)rateView didChangeRatingState:(NMRateViewState)state;

@end

@interface NMRateView : RateView


@property(nonatomic,weak)id<NMRateViewDelegate> stateDelegate;

@end
