#import "_NMShift.h"

typedef NS_ENUM(NSInteger, NMShiftState) {
    NMShiftStateActive = 0,
    NMShiftStateEnded = 1,
    NMShiftStateHalted = 2,
};

@interface NMShift : _NMShift {}

@property (readonly) NMShiftState state;
@property (readonly) BOOL hasPendingDeliveries;
@property (readonly) NSNumber *countOfPendingDeliveries;

- (NSArray*)sortedDeliveryPlaces;

@end
