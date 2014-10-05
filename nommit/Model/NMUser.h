#import "_NMUser.h"
#import <Overcoat.h>

typedef NS_ENUM(NSInteger, NMUserState) {
    NMUserStateRegistered = 0,
    NMUserStateActivated = 1
};

@interface NMUser : _NMUser

+ (NMUser*)currentUser;
+ (void)setCurrentUser:(NMUser*)currentUser;

@property (nonatomic, readonly) NSNumber *credit;
@property (readonly) NSString *formattedPhone;
@property (readonly) NMUserState state;

- (BOOL)hasActiveDeliveries;
- (BOOL)hasOrdersPendingRating;

@end
