#import "NMCourier.h"


@interface NMCourier ()

// Private interface goes here.

@end


@implementation NMCourier

+ (NMCourier *)currentCourier {
    return [NMCourier MR_findFirstByAttribute:@"user" withValue:NMUser.currentUser];
}

@end
