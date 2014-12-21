//
//  NMRateView.m
//  nommit
//
//  Created by Jarred Sumner on 10/11/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "NMRateView.h"

@implementation NMRateView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([_stateDelegate respondsToSelector:@selector(rateView:didChangeRatingState:)]) {
        [_stateDelegate rateView:self didChangeRatingState:NMRateViewStateStarted];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if ([_stateDelegate respondsToSelector:@selector(rateView:didChangeRatingState:)]) {
        [_stateDelegate rateView:self didChangeRatingState:NMRateViewStateEnded];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if ([_stateDelegate respondsToSelector:@selector(rateView:didChangeRatingState:)]) {
        [_stateDelegate rateView:self didChangeRatingState:NMRateViewStateEnded];
    }
}


@end
