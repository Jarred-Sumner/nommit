#import "_NMPlace.h"
#import "NMApi.h"

@class NMShift;

typedef void (^NMApiCompletionBlock)(id response, NSError *error);

@interface NMPlace : _NMPlace {}

+ (BOOL)hasActivePlaces;
+ (NMPlace *)activePlace;
+ (void)setActivePlace:(NMPlace*)place;

+ (void)refreshAllWithCompletion:(NMApiCompletionBlock)completion;

@property (readonly) NSArray *foods;
- (NMDeliveryPlace*)deliveryPlaceForShift:(NMShift*)shift inContext:(NSManagedObjectContext*)context;

@end
