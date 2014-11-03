#import "NMOrder.h"

@interface NMOrder ()

@end


@implementation NMOrder

- (NMOrderState)state {
    return (NMOrderState)[self.stateID integerValue];
}

- (NMOrderChargeState)chargeState {
    return (NMOrderChargeState)[self.chargeStateID integerValue];
}

@end
