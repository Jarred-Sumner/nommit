#import "NMFoodDeliveryPlace.h"

@implementation NMFoodDeliveryPlace

+ (NMFoodDeliveryPlace *)previousPlace {
    NSArray *places = [self placesForCourier:NMCourier.currentCourier];
    if (places.count > 1) {
        return places[places.count - 1];
    } else return nil;
}

+ (NMFoodDeliveryPlace *)currentPlace {
    NSArray *places = [self placesForCourier:NMCourier.currentCourier];
    return places[0];
}

+ (NMFoodDeliveryPlace *)nextPlace {
    NSArray *places = [self placesForCourier:NMCourier.currentCourier];
    if (places.count > 1) {
        return places[1];
    } else return nil;
}

+ (NSArray*)placesForCourier:(NMCourier*)courier {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courier = %@ AND (stateID = %@ OR stateID = %@)", courier,@(NMFoodDeliveryPlaceStateActive),@(NMFoodDeliveryPlaceStateReady)];

    return [NMFoodDeliveryPlace MR_findAllSortedBy:@"index" ascending:YES withPredicate:predicate];
}
@end
