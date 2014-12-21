//
//  NMDeliveryPlaceApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/29/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "MTLModel.h"

@interface NMDeliveryPlaceApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSDate *arrivesAt;
@property (nonatomic, strong) NSNumber *index;

@property (nonatomic, strong) NSArray *foods;
@property (nonatomic, strong) NSMutableArray *orders;
@property (nonatomic, strong) NMPlaceApiModel *place;

@end
