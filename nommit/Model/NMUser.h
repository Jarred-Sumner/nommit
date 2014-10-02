#import "_NMUser.h"
#import <Overcoat.h>

@interface NMUser : _NMUser

+ (NMUser*)currentUser;
+ (void)setCurrentUser:(NMUser*)currentUser;

@property (readonly) NSString *formattedPhone;

- (BOOL)hasActiveDeliveries;
- (BOOL)hasOrdersPendingRating;

@end
