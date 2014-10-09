//
//  NMOrderApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"

@class NMLocationApiModel, NMFoodApiModel, NMUserApiModel, NMPlaceApiModel, NMCourierApiModel, NMFood, NMPlace;

@interface NMOrderApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSDate *placedAt;
@property (nonatomic, strong) NSNumber *priceInCents;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSNumber *chargeStateID;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *promoCode;
@property (nonatomic, strong) NSNumber *discountInCents;
@property (nonatomic, strong) NSNumber *tipInCents;
@property (nonatomic, strong) NSDate *deliveredAt;
@property (nonatomic, strong) NSNumber *priceChargedInCents;

@property (nonatomic, strong) NMPlaceApiModel *place;
@property (nonatomic, strong) NMFoodApiModel *food;
@property (nonatomic, strong) NMUserApiModel *user;
@property (nonatomic, strong) NMCourierApiModel *courier;

- (NSDictionary*)createParamsWithFood:(NMFood*)food place:(NMPlace*)place;
@end
