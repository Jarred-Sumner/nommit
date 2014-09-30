#import "_NMDeliveryPlace.h"

typedef NS_ENUM(NSInteger, NMDeliveryPlaceState) {
    NMDeliveryPlaceStateReady = 0,
    NMDeliveryPlaceStateArrived = 1,
    NMDeliveryPlaceStateEnded = 2
};

@interface NMDeliveryPlace : _NMDeliveryPlace {}
// Custom logic goes here.
@end
