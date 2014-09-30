#import "NMShift.h"


@interface NMShift ()

// Private interface goes here.

@end


@implementation NMShift

- (NMShiftState)state {
    return [self.stateID integerValue];
}

@end
