#import "_NMCourier.h"

@interface NMCourier : _NMCourier {}

+ (NMCourier *)currentCourier;

@property (readonly) NSArray *deliveryPlaces;
@property (readonly) NMShift *currentShift;

@end
