#import "NMShift.h"


@interface NMShift ()

// Private interface goes here.

@end


@implementation NMShift

- (NMShiftState)state {
    return [self.stateID integerValue];
}

- (NSArray*)sortedDeliveryPlaces {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shift = %@", self];
    return [NMDeliveryPlace MR_findAllSortedBy:@"index" ascending:YES withPredicate:predicate];
}

- (NSNumber*)countOfPendingDeliveries {
    return @([NMShift MR_countOfEntitiesWithPredicate:[self pendingDeliveryPredicate]]);
}

- (BOOL)pendingDeliveries {
    return self.countOfPendingDeliveries.integerValue > 0;
}

#pragma mark - Utility Methods

- (NSPredicate*)pendingDeliveryPredicate {
    return [NSPredicate predicateWithFormat:@"stateID = %@ AND courier = %@", @(NMOrderStateActive), self.courier];
}

@end
