#import "NMFood.h"
#define ONE_DAY 60 * 60 * 24

@interface NMFood ()

// Private interface goes here.

@end


@implementation NMFood

- (NMFoodState)state {
    return (NMFoodState)self.stateIDValue;
}

- (BOOL)isActive {
    return self.state == NMFoodStateActive && self.endDate.timeIntervalSinceNow > 0.0;
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

- (NSDecimalNumber*)priceAtQuantity:(NSNumber*)quantity {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"food = %@ AND quantity = %@", self, quantity];
    NMPrice *price = [NMPrice MR_findFirstWithPredicate:predicate];
    return price.price;
}

@end
