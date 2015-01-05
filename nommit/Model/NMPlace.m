#import "NMPlace.h"

static NSString *NMActivePlaceKey = @"ActivePlace";
static NSNumber *NMCurrentPlaceID;

@interface NMPlace ()

// Private interface goes here.

@end


@implementation NMPlace

+ (NMPlace *)activePlace {
    if (NMCurrentPlaceID) {
        NMPlace *place = [NMPlace MR_findFirstByAttribute:@"uid" withValue:NMCurrentPlaceID];
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
        NMCurrentPlaceID = place.uid;
    } else {
        NMCurrentPlaceID = nil;
    }
}

- (NSArray*)foods {
    NSMutableSet *foods = [[NSMutableSet alloc] init];
    [[NMDeliveryPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"place = %@", self]] enumerateObjectsUsingBlock:^(NMDeliveryPlace *deliveryPlace, NSUInteger idx, BOOL *stop) {
        [foods addObjectsFromArray:deliveryPlace.foods.allObjects];
    }];
    return [foods allObjects];
}

+ (BOOL)hasActivePlaces {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"stateID IN %@", @[@(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateReady)]];
    return [NMDeliveryPlace MR_countOfEntitiesWithPredicate:predicate] > 1;
}

// We can't just call GET /places.
// We don't want to return every fucking place with a bunch of empty arrays. That means the view renders at >= 5000ms. 5 seconds is too long.
// So, we only update active ones. Then, we mark all the others as inactive.
+ (void)refreshAllWithCompletion:(NMApiCompletionBlock)completion {
    [[NMApi instance] GET:@"places" parameters:nil completionWithErrorHandling:^(OVCResponse *response, NSError *error) {

        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            NSArray *activePlaces = [MTLJSONAdapter modelsOfClass:[NMPlaceApiModel class] fromJSONArray:response.result error:nil];
            
            NSMutableSet *activePlaceIDs = [[NSMutableSet alloc] init];
            for (NMPlaceApiModel *model in activePlaces) {
                [MTLManagedObjectAdapter managedObjectFromModel:model insertingIntoContext:localContext error:nil];
                [activePlaceIDs addObject:model.uid];
            }
            
            // After we update the active places
            // We make sure that the inactive places are marked as such.
            NSArray *inactivePlaces = [NMPlace MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"NOT(uid in %@)", activePlaceIDs] inContext:localContext];
            for (NMPlace *inactivePlace in inactivePlaces) {
                inactivePlace.foodCount = @0;
            }
            
        } completion:^(BOOL success, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(response, error);
            });
        }];
        
    }];
}

- (NMDeliveryPlace*)deliveryPlaceForShift:(NMShift*)shift inContext:(NSManagedObjectContext*)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shift = %@ AND place = %@ AND stateID IN %@", shift, self, @[@(NMDeliveryPlaceStateArrived), @(NMDeliveryPlaceStateReady), @(NMDeliveryPlaceStateHalted)]];
    
    return [NMDeliveryPlace MR_findFirstWithPredicate:predicate sortedBy:@"stateID" ascending:YES inContext:context];
}

@end
