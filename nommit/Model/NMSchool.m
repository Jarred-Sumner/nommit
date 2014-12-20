#import "NMSchool.h"


@interface NMSchool ()

// Private interface goes here.

@end


@implementation NMSchool


- (NMSchoolMessageState)messageState {
    if (self.motd && [self.motdExpiration timeIntervalSinceNow] > 0) {
        return NMSchoolMessageStateMOTD;
    } else if (self.fromHours && self.toHours) {
        return NMSchoolMessageStateHours;
    } else {
        return NMSchoolMessageStateSpecialEvents;
    }
}

@end
