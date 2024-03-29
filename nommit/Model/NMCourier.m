#import "NMCourier.h"


@interface NMCourier ()

// Private interface goes here.

@end

static id currentCourier;

@implementation NMCourier

- (NMShift *)currentShift {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(stateID = %@ OR stateID = %@) AND courier = %@", @(NMShiftStateActive), @(NMShiftStateHalted), self];
    return [NMShift MR_findFirstWithPredicate:predicate sortedBy:@"stateID" ascending:YES];
}

- (NSArray*)deliveryPlaces {
    return [NMDeliveryPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"shift IN %@", self.shifts.allObjects]];
}

@end
