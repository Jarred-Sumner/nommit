#import "NMFood.h"


@interface NMFood ()

// Private interface goes here.

@end


@implementation NMFood

- (NSFoodState)state {
    return (NSFoodState)[self rawStateValue];
}



@end
