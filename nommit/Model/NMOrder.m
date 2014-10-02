#import "NMOrder.h"

@interface NMOrder ()

@end


@implementation NMOrder

- (NMOrderState)state {
    return (NMOrderState)[self.stateID integerValue];
}

@end
