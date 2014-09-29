#import "_NMPlace.h"

@interface NMPlace : _NMPlace {}

+ (NMPlace *)activePlace;
+ (void)setActivePlace:(NMPlace*)place;

@property (readonly) NSArray *foods;

@end
