#import "NMPlace.h"

static NSString *NMActivePlaceKey = @"ActivePlace";

@interface NMPlace ()

// Private interface goes here.

@end


@implementation NMPlace

+ (NMPlace *)activePlace {
    NSNumber *activePlaceID = [[NSUserDefaults standardUserDefaults] valueForKey:NMActivePlaceKey];
    if (activePlaceID) {
        return [NMPlace MR_findFirstByAttribute:@"uid" withValue:activePlaceID];
    } else {
        return [NMPlace MR_findFirstOrderedByAttribute:@"foodCount" ascending:NO];
    }
}

+ (void)setActivePlace:(NMPlace*)place {
    [[NSUserDefaults standardUserDefaults] setObject:place.uid forKey:NMActivePlaceKey];
}

- (NSArray*)foods {
    NSMutableArray *foods = [[NSMutableArray alloc] init];
    [[NMDeliveryPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"place = %@", self]] enumerateObjectsUsingBlock:^(NMDeliveryPlace *deliveryPlace, NSUInteger idx, BOOL *stop) {
        [foods addObjectsFromArray:deliveryPlace.foods.allObjects];
    }];
    return foods;
}

@end
