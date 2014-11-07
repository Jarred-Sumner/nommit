#import "_NMFood.h"
#import <Overcoat.h>

typedef NS_ENUM(NSInteger, NMFoodState) {
    NMFoodStateActive = 0,
    NMFoodStateHalted = 1,
    NMFoodStateEnded = 2,
};

typedef NS_ENUM(NSInteger, NMFoodTimingState) {
    NMFoodTimingStatePending = 0,
    NMFoodTimingStateActive,
    NMFoodTimingStateExpired
};

typedef NS_ENUM(NSInteger, NMFoodQuantityState) {
    NMFoodQuantityStateActive = 0,
    NMFoodQuantityStateSoldOut
};

@interface NMFood : _NMFood

@property (readonly) NMFoodState state;
@property (readonly) NMFoodTimingState timingState;
@property (readonly) NMFoodQuantityState quantityState;

@property (readonly) NSNumber *remainingOrders;
@property (readonly) NSURL *headerImageAsURL;
@property (readonly) NSURL *thumbnailImageAsURL;

- (BOOL)isActive;

- (NSDecimalNumber*)priceAtQuantity:(NSNumber*)quantity;

+ (NSInteger)countOfActiveFoods;
@end
