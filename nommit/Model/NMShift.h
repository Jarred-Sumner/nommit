#import "_NMShift.h"

typedef NS_ENUM(NSInteger, NMShiftState) {
    NMShiftStateActive = 0,
    NMShiftStateEnded = 1,
    NMShiftStateHalted = 2,
};

@interface NMShift : _NMShift {}

@property (readony) NMShiftState state;

@end
