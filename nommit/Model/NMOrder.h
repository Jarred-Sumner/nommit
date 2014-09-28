#import "_NMOrder.h"

typedef NS_ENUM(NSInteger, NMOrderState) {
    NMOrderStateCancelled = -1,
    NMOrderStateActive = 0,
    NMOrderStateDelivered = 1
};

@interface NMOrder : _NMOrder {}

@end
