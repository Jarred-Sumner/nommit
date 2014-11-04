#import "_NMOrder.h"

typedef NS_ENUM(NSInteger, NMOrderState) {
    NMOrderStateCancelled = -1,
    NMOrderStateActive = 0,
    NMOrderStateArrived = 1,
    NMOrderStateDelivered = 2,
    NMOrderStateRated = 3
};

typedef NS_ENUM(NSInteger, NMOrderChargeState) {
    NMOrderChargeStateFailed = -1,
    NMOrderChargeStateNotCharged = 0,
    NMOrderChargeStateCharged = 1,
    NMOrderChargeStatePaid = 2,
    NMOrderChargeStateRefunded = 3
};

@interface NMOrder : _NMOrder {}

@property (readonly) NMOrderState state;
@property (readonly) NMOrderChargeState chargeState;

+ (NSArray*)pendingStates;

@end
