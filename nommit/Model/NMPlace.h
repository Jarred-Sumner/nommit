#import "_NMPlace.h"
#import "NMApi.h"

typedef void (^NMApiCompletionBlock)(id response, NSError *error);

@interface NMPlace : _NMPlace {}

+ (NMPlace *)activePlace;
+ (void)setActivePlace:(NMPlace*)place;

+ (void)refreshAllWithCompletion:(NMApiCompletionBlock)completion;

@property (readonly) NSArray *foods;

@end
