#import "NMOrder.h"

@interface NMOrder ()

@end


@implementation NMOrder

+ (NSArray*)pendingStates {
    return @[ @(NMOrderStateActive), @(NMOrderStateArrived) ];
}

- (NMOrderState)state {
    return (NMOrderState)[self.stateID integerValue];
}

- (NMOrderChargeState)chargeState {
    return (NMOrderChargeState)[self.chargeStateID integerValue];
}

@end
