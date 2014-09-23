//
//  NMOrderApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"

@class NMLocationApiModel, NMFoodApiModel, NMUserApiModel;

@interface NMOrderApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSNumber *priceInCents;
@property (nonatomic, strong) NSDate *placedAt;
@property (nonatomic, strong) NSDate *deliveredAt;

@property (nonatomic, strong) NMLocationApiModel *location;
@property (nonatomic, strong) NMFoodApiModel *food;
@property (nonatomic, strong) NMUserApiModel *user;


@end
