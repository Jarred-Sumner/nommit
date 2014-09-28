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


- (NSString *)formattedPhone {
    NBPhoneNumberUtil *util = [NBPhoneNumberUtil sharedInstance];
    return [util format:[self phoneNumber] numberFormat:NBEPhoneNumberFormatNATIONAL error:nil];
}

- (NBPhoneNumber*)phoneNumber {
    NBPhoneNumberUtil *phoneUtil = [NBPhoneNumberUtil sharedInstance];
    return [phoneUtil parse:self.phone defaultRegion:@"US" error:nil];
}



@end
