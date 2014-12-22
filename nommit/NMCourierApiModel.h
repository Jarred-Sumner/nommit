//
//  NMCourierApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/24/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "MTLModel.h"

@class NMSellerApiModel;

@interface NMCourierApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *stateID;

@property (nonatomic, strong) NMUserApiModel *user;
@property (nonatomic, strong) NMSellerApiModel *seller;

@end
