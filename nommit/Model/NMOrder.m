#import "NMOrder.h"

@interface NMOrder ()

@end


@implementation NMOrder

- (NSNumber *)price {
    return @(self.priceChargedInCents.doubleValue / 100.f);
}

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
