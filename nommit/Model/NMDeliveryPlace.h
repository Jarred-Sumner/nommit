#import "_NMDeliveryPlace.h"

typedef NS_ENUM(NSInteger, NMDeliveryPlaceState) {
    NMDeliveryPlaceStateReady = 0,
    NMDeliveryPlaceStateArrived = 1,
    NMDeliveryPlaceStateHalted = 2, 
    NMDeliveryPlaceStateEnded = 3,
    NMDeliveryPlaceStatePending = 4
};

@interface NMDeliveryPlace : _NMDeliveryPlace {}

+ (NMDeliveryPlace*)deliveryPlaceForFood:(NMFood*)food place:(NMPlace*)place;

@end
