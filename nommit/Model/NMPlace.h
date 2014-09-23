#import "_NMPlace.h"

@interface NMPlace : _NMPlace {}

+ (NMPlace *)activePlace;
+ (void)setActivePlace:(NMPlace*)place;

@end
