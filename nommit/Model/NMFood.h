#import "_NMFood.h"
#import <Overcoat.h>

typedef NS_ENUM(NSInteger, NMFoodState) {
    NMFoodStateUnknown = 0,
    NMFoodStateActive = 1,
    NMFoodStateEnded = 2
};

@interface NMFood : _NMFood

@property (readonly) NMFoodState state;

@property (readonly) NSNumber *remainingOrders;
@property (readonly) NSURL *headerImageAsURL;
@property (readonly) NSURL *thumbnailImageAsURL;

+ (NSArray*)activeFoods;

- (BOOL)isActive;

@end
