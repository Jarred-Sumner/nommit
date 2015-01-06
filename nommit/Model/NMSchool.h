#import "_NMSchool.h"

typedef NS_ENUM(NSInteger, NMSchoolMessageState) {
    NMSchoolMessageStateSpecialEvents = 0,
    NMSchoolMessageStateHours,
    NMSchoolMessageStateMOTD
};

@interface NMSchool : _NMSchool {}

+ (void)setCurrentSchool:(NMSchool*)school;
+ (NMSchool*)currentSchool;

@property (readonly) NMSchoolMessageState messageState;
@property (readonly) BOOL hasHours;
@property (readonly) BOOL isClosed;
@end
