//
//  NMShiftApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "MTLModel.h"

@interface NMShiftApiModel : MTLModel<MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSNumber *revenueGeneratedInCents;

@property (nonatomic, strong) NMCourierApiModel *courier;

@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, strong) NSArray *places;
@property (readonly) NSArray *activeDeliveryPlaces;

@end
