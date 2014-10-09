#import "NMPlace.h"

static NSString *NMActivePlaceKey = @"ActivePlace";

@interface NMPlace ()

// Private interface goes here.

@end


@implementation NMPlace

+ (NMPlace *)activePlace {
    NSNumber *activePlaceID = [[NSUserDefaults standardUserDefaults] valueForKey:NMActivePlaceKey];
    if (activePlaceID) {
        NMPlace *place = [NMPlace MR_findFirstByAttribute:@"uid" withValue:activePlaceID];
        if (place) {
            return place;
        } else {
            [self setActivePlace:nil];
            return nil;
        }
    } else return nil;
}

+ (void)setActivePlace:(NMPlace*)place {
    if (place) {
        [[Mixpanel sharedInstance] track:@"Chose Place" properties:@{ @"Name" : place.name, @"ID" : place.uid }];
        [[NSUserDefaults standardUserDefaults] setObject:place.uid forKey:NMActivePlaceKey];
    } else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:NMActivePlaceKey];
    }
}

- (NSArray*)foods {
    NSMutableSet *foods = [[NSMutableSet alloc] init];
    [[NMDeliveryPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"place = %@", self]] enumerateObjectsUsingBlock:^(NMDeliveryPlace *deliveryPlace, NSUInteger idx, BOOL *stop) {
        [foods addObjectsFromArray:deliveryPlace.foods.allObjects];
    }];
    return [foods allObjects];
}


// We can't just call GET /places.
// We don't want to return every fucking place with a bunch of empty arrays. That means the view renders at >= 5000ms. 5 seconds is too long.
// So, we only update active ones. Then, we mark all the others as inactive.
+ (void)refreshAllWithCompletion:(NMApiCompletionBlock)completion {
    [[NMApi instance] GET:@"places" parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {
        
        __block NSMutableArray *activePlaceIDs = [[NSMutableArray alloc] init];
        for (NMPlaceApiModel *placeModel in response.result) {
            if (placeModel.foodCount.intValue > 0) {
                [activePlaceIDs addObject:placeModel.uid];
            }
        }
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(uid IN %@)", activePlaceIDs];
            NSArray *inactivePlaces = [NMPlace MR_findAllWithPredicate:predicate inContext:localContext];
            for (NMPlace *place in inactivePlaces) {
                place.foodCount = @0;
            }
            
        } completion:^(BOOL success, NSError *error) {
            completion(response, error);
        }];

        
    }];
}

@end
