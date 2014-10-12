#import "NMPrice.h"


@interface NMPrice ()

// Private interface goes here.

@end


@implementation NMPrice

+ (NSNumber*)priceIDForFood:(NMFood*)food quantity:(NSNumber*)quantity {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"quantity = %@ AND food = %@", quantity, food];
    return [[NMPrice MR_findFirstWithPredicate:predicate] uid];
}

@end
