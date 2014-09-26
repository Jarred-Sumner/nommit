#import "NMUser.h"

#import "ECPhoneNumberFormatter.h"

@implementation NMUser

static id NMCurrentUser;

+ (NMUser *)currentUser {
    if (!NMCurrentUser) {
        NSLog(@"Users: %@", [NMSession userID]);
        NMCurrentUser = [NMUser MR_findFirstByAttribute:@"facebookUID" withValue:[NMSession userID]];
    }
    return NMCurrentUser;
}

+ (void)setCurrentUser:(NMUser*)currentUser {
    NMCurrentUser = currentUser;
}


- (NSString *)formattedPhone {
    ECPhoneNumberFormatter *formatter = [[ECPhoneNumberFormatter alloc] init];
    return [formatter stringForObjectValue:self.phone];
}



@end
