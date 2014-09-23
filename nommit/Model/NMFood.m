#import "NMFood.h"
#define ONE_DAY 60 * 60 * 24

@interface NMFood ()

// Private interface goes here.

@end


@implementation NMFood


+ (NSArray*)activeFoods {
    NSPredicate *active = [NSPredicate predicateWithFormat:@"stateID = %@ AND endDate > %@", @(NMFoodStateActive), [NSDate date]];
    NSFetchRequest *request = [NMFood MR_requestAllWithPredicate:active];
    return [NMFood MR_executeFetchRequest:request];
}

- (NMFoodState)state {
    return (NMFoodState)self.stateIDValue;
}

- (NSURL *)headerImageAsURL {
    return [NSURL URLWithString:self.headerImageURL];
}

- (NSURL *)thumbnailImageAsURL {
    return [NSURL URLWithString:self.thumbnailImageURL];
}

- (NSNumber *)remainingOrders {
    return @(self.orderGoal.integerValue - self.orderCount.integerValue);
}

@end
