#import "NMSchool.h"


@interface NMSchool ()

// Private interface goes here.

@end


@implementation NMSchool

static id NMCurrentSchool;

+ (void)setCurrentSchool:(NMSchool*)school {
    NMCurrentSchool = school;
}

+ (NMSchool*)currentSchool {
    if (!NMCurrentSchool) {
        NMCurrentSchool = [NMSchool MR_findFirstByAttribute:@"uid" withValue:[NMSession schoolID]];
    }
    return NMCurrentSchool;
}

- (NMSchoolMessageState)messageState {
    if (self.motd && [self.motdExpiration timeIntervalSinceNow] > 0) {
        return NMSchoolMessageStateMOTD;
    } else if (self.hasHours) {
        return NMSchoolMessageStateHours;
    } else {
        return NMSchoolMessageStateSpecialEvents;
    }
}

- (BOOL)hasHours {
    return self.fromHours && self.toHours;
}

- (BOOL)isClosed {
    if (!self.hasHours) return YES;
    if (!(NSDate.date.day > 0 && NSDate.date.day < 6)) return YES;
    
    NSInteger secondOfToday = NSDate.date.second + (NSDate.date.minute * 60) + (NSDate.date.hour * 60 * 60);
    NSInteger startSecond = self.fromHours.second + (self.fromHours.minute * 60) + (self.fromHours.hour * 60 * 60);
    NSInteger endSecond = self.toHours.second + (self.toHours.minute * 60) + (self.toHours.hour * 60 * 60);
    return !(secondOfToday > startSecond && endSecond > secondOfToday);
}

@end
