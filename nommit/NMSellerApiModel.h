//
//  NMSellerApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/20/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import "MTLModel.h"

@class NMSchoolApiModel;

@interface NMSellerApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *logoURL;

@property (nonatomic, strong) NMSchoolApiModel *school;

@end
