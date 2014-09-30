#import "NMCourier.h"


@interface NMCourier ()

// Private interface goes here.

@end


@implementation NMCourier

+ (NMCourier *)currentCourier {
    return [NMCourier MR_findFirstByAttribute:@"user" withValue:NMUser.currentUser];
}

- (NSArray*)deliveryPlaces {
    return [NMDeliveryPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"shift IN %@", self.shifts.allObjects]];
}

@end
