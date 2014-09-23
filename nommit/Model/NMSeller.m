#import "NMSeller.h"


@interface NMSeller ()

// Private interface goes here.

@end


@implementation NMSeller


- (NSURL *)logoAsURL {
    return [NSURL URLWithString:self.logoURL];
}

@end
