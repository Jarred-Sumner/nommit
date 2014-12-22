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

@property (nonatomic, strong) NSMutableArray *orders;
@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) NSArray *placeIDs;
@property (nonatomic, strong) NSArray *deliveryPlaces;
@property (readonly) NSArray *activeDeliveryPlaces;

- (void)removeOrder:(NMOrderApiModel*)order;

@end
