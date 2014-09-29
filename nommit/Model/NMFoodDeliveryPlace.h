#import "_NMFoodDeliveryPlace.h"

typedef NS_ENUM(NSInteger, NMFoodDeliveryPlaceState) {
    NMFoodDeliveryPlaceStateReady = 0,
    NMFoodDeliveryPlaceStateActive = 1,
    NMFoodDeliveryPlaceStateEnded = 2
};

@interface NMFoodDeliveryPlace : _NMFoodDeliveryPlace {}

+ (NMFoodDeliveryPlace *)previousPlace;
+ (NMFoodDeliveryPlace *)currentPlace;
+ (NMFoodDeliveryPlace *)nextPlace;

+ (NSArray*)placesForCourier:(NMCourier*)courier;

@end
