#import "_NMFood.h"
#import <Overcoat.h>

typedef NS_ENUM(NSInteger, NMFoodState) {
    NMFoodStateActive = 0,
    NMFoodStateHalted = 1,
    NMFoodStateEnded = 2,
};

@interface NMFood : _NMFood

@property (readonly) NMFoodState state;

@property (readonly) NSNumber *remainingOrders;
@property (readonly) NSURL *headerImageAsURL;
@property (readonly) NSURL *thumbnailImageAsURL;

- (BOOL)isActive;

- (NSDecimalNumber*)priceAtQuantity:(NSNumber*)quantity;

@end
