#import "NMUser.h"

#import <libPhoneNumber-iOS/NBPhoneNumberUtil.h>
#import <Crashlytics/Crashlytics.h>

@implementation NMUser

static id NMCurrentUser;

+ (void)setCurrentUser:(NMUser*)currentUser {
    NMCurrentUser = currentUser;
}

+ (NMUser *)currentUser {
    if (!NMCurrentUser) {
        NMCurrentUser = [NMUser MR_findFirstByAttribute:@"facebookUID" withValue:[NMSession userID]];
        if (NMCurrentUser) {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            if ([NMCurrentUser fullName]) [dict setObject:@"Name" forKey:[NMCurrentUser fullName]];
            
            if ([NMCurrentUser email]) [dict setObject:@"Email" forKey:[NMCurrentUser email]];
            
            if ([NMCurrentUser phone]) [dict setObject:@"Phone" forKey:[NMCurrentUser phone]];
            
            [[Crashlytics sharedInstance] setUserIdentifier:[NMCurrentUser facebookUID]];
            [[Crashlytics sharedInstance] setUserEmail:[NMCurrentUser email]];
            [[Crashlytics sharedInstance] setUserName:[NMCurrentUser fullName]];

            [[Mixpanel sharedInstance].people setOnce:dict];
        }
    }
    return NMCurrentUser;
}



- (NMUserState)state { return (NMUserState)self.stateID.integerValue; }

- (NSString *)formattedPhone {
    NBPhoneNumberUtil *util = [NBPhoneNumberUtil sharedInstance];
    return [util format:[self phoneNumber] numberFormat:NBEPhoneNumberFormatNATIONAL error:nil];
}

- (NSNumber*)credit {
    return @([self.creditInCents intValue] / 100);
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
