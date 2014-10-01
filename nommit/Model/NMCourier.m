#import "NMCourier.h"


@interface NMCourier ()

// Private interface goes here.

@end

static id currentCourier;

@implementation NMCourier

+ (NMCourier *)currentCourier {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        currentCourier = [NMCourier MR_findFirstByAttribute:@"user" withValue:NMUser.currentUser];
    });
    return currentCourier;
    
}

- (NMShift *)currentShift {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(stateID = %@ OR stateID = %@) AND courier = %@", @(NMShiftStateActive), @(NMShiftStateHalted), self];
    return [NMShift MR_findFirstWithPredicate:predicate];
}

- (NSArray*)deliveryPlaces {
    return [NMDeliveryPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"shift IN %@", self.shifts.allObjects]];
}

@end
