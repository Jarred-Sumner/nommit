//
//  NMFoodDeliveryPlaceApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/27/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "MTLModel.h"

@interface NMFoodDeliveryPlaceApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSNumber *waitInterval;
@property (nonatomic, strong) NSDate *eta;

@property (nonatomic, strong) NMFoodApiModel *food;
@property (nonatomic, strong) NMPlaceApiModel *place;
@property (nonatomic, strong) NMCourierApiModel *courier;

@end
