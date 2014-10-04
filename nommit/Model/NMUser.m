#import "NMUser.h"

#import <libPhoneNumber-iOS/NBPhoneNumberUtil.h>

@implementation NMUser

static id NMCurrentUser;

+ (NMUser *)currentUser {
    if (!NMCurrentUser) {
        NMCurrentUser = [NMUser MR_findFirstByAttribute:@"facebookUID" withValue:[NMSession userID]];
    }
    return NMCurrentUser;
}

+ (void)setCurrentUser:(NMUser*)currentUser {
    NMCurrentUser = currentUser;
}

- (NMUserState)state { return (NMUserState)self.stateID.integerValue; }

- (NSString *)formattedPhone {
    NBPhoneNumberUtil *util = [NBPhoneNumberUtil sharedInstance];
    return [util format:[self phoneNumber] numberFormat:NBEPhoneNumberFormatNATIONAL error:nil];
}

- (NBPhoneNumber*)phoneNumber {
    NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
    return [phoneUtil parse:self.phone defaultRegion:@"US" error:nil];
}

- (BOOL)hasActiveDeliveries {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"stateID = %@ AND (courier IN %@)", @(NMShiftStateActive), self.couriers.allObjects];
    return [NMShift MR_countOfEntitiesWithPredicate:predicate] > 0;
}

- (BOOL)hasOrdersPendingRating {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user = %@ and stateID = %@", self, @(NMOrderStateDelivered)];
    return [NMOrder MR_countOfEntitiesWithPredicate:predicate] > 0;
}



@end
