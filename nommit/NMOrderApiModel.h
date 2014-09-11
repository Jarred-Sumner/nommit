//
//  NMOrderApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"

@class NMAddressApiModel, NMFoodApiModel, NMUserApiModel;

@interface NMOrderApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>


@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSNumber *priceInCents;
@property (nonatomic, strong) NSDate *placedAt;
@property (nonatomic, strong) NSDate *deliveredAt;

@property (nonatomic, strong, readonly) NMAddressApiModel *address;
@property (nonatomic, strong, readonly) NMFoodApiModel *food;
@property (nonatomic, strong, readonly) NMUserApiModel *user;


@end
