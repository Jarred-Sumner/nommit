#import "_NMFood.h"
#import <Overcoat.h>

typedef NS_ENUM(NSInteger, NSFoodState) {
    NSFoodStateUnknown = 0,
    NSFoodStateActive = 1,
    NSFoodStateEnded = 2
};

@interface NMFood : _NMFood

@property (readonly) NSFoodState state;

@end
