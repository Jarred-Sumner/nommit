#import "NMDeliveryPlace.h"


@interface NMDeliveryPlace ()

// Private interface goes here.

@end


@implementation NMDeliveryPlace


+ (NMDeliveryPlace*)deliveryPlaceForFood:(NMFood*)food place:(NMPlace*)place {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ in foods and place = %@", food, place];
    return [NMDeliveryPlace MR_findFirstWithPredicate:predicate];
}

@end
