#import "_NMOrder.h"

typedef NS_ENUM(NSInteger, NMOrderState) {
    NMOrderStateCancelled = -1,
    NMOrderStateActive = 0,
    NMOrderStateArrived = 1,
    NMOrderStateDelivered = 2,
    NMOrderStateRated = 3
};

@interface NMOrder : _NMOrder {}

@property (readonly) NMOrderState state;

@end
