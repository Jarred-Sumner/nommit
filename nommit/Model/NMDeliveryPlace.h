#import "_NMDeliveryPlace.h"

typedef NS_ENUM(NSInteger, NMDeliveryPlaceState) {
    NMDeliveryPlaceStateReady = 0,
    NMDeliveryPlaceStateArrived = 1,
    NMDeliveryPlaceStateHalted = 2, 
    NMDeliveryPlaceStateEnded = 3
};

@interface NMDeliveryPlace : _NMDeliveryPlace {}
// Custom logic goes here.
@end
