//
//  NMSchoolApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 12/17/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "MTLModel.h"

@interface NMSchoolApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSDate *fromHours;
@property (nonatomic, strong) NSDate *toHours;

@end
