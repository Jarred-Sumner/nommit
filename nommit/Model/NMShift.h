#import "_NMShift.h"

typedef NS_ENUM(NSInteger, NMShiftState) {
    NMShiftStateActive = 0,
    NMShiftStateHalted = 1,
    NMShiftStateEnded = 2,
};

@interface NMShift : _NMShift {}

@property (readonly) NMShiftState state;
@property (readonly) BOOL hasPendingDeliveries;
@property (readonly) NSNumber *countOfPendingDeliveries;
@property (readonly) NSArray *activeDeliveryPlaces;

- (NSDictionary*)sortedDeliveryPlaces;

@end
