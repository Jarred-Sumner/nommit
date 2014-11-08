#import "NMFood.h"
#define ONE_DAY 60 * 60 * 24

@interface NMFood ()

// Private interface goes here.

@end


@implementation NMFood

- (NMFoodState)state {
    return (NMFoodState)self.stateIDValue;
}

- (BOOL)orderable {
    return self.state == NMFoodStateActive && self.timingState == NMFoodTimingStateActive && self.quantityState == NMFoodQuantityStateActive;
}

- (NMFoodTimingState)timingState {
    if (self.startDate.timeIntervalSinceNow < 0.0 && self.endDate.timeIntervalSinceNow > 0.0) {
        return NMFoodTimingStateActive;
    } else if (self.startDate.timeIntervalSinceNow > 0.0) {
        return NMFoodTimingStatePending;
    } else {
        return NMFoodTimingStateExpired;
    }
}

- (NMFoodQuantityState)quantityState {
    if (self.orderCount.intValue >= self.orderGoal.intValue) {
        return NMFoodQuantityStateSoldOut;
    } else return NMFoodQuantityStateActive;
}


+ (NSInteger)countOfActiveFoods {
    NSArray *dpStates = @[ @(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateReady) ];
    NSArray *foodStates = @[ @(NMFoodStateActive) ];
    NSPredicate *activePredicate = [NSPredicate predicateWithFormat:@"( (endDate >= %@) AND (startDate <= %@) AND (stateID IN %@) ) AND deliveryPlaces.@count > 0 AND (ANY SUBQUERY(deliveryPlaces, $dp, $dp.stateID IN %@).@count > 0)", [NSDate date], [NSDate date], foodStates, dpStates];

    return [NMFood MR_countOfEntitiesWithPredicate:activePredicate];
}



- (BOOL)isActive {
    return self.state == NMFoodStateActive && self.endDate.timeIntervalSinceNow > 0.0 && self.startDate.timeIntervalSinceNow < 0.0;
}

- (NSURL *)headerImageAsURL {
    return [NSURL URLWithString:self.headerImageURL];
}

- (NSURL *)thumbnailImageAsURL {
    return [NSURL URLWithString:self.thumbnailImageURL];
}

- (NSNumber *)remainingOrders {
    return @(self.orderGoal.integerValue - self.orderCount.integerValue);
}

- (NSDecimalNumber*)priceAtQuantity:(NSNumber*)quantity {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"food = %@ AND quantity = %@", self, quantity];
    NMPrice *price = [NMPrice MR_findFirstWithPredicate:predicate];
    return price.price;
}

@end
