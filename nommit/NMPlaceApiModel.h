//
//  NMPlaceApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/20/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "MTLModel.h"

@interface NMPlaceApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *foodCount;
@property (nonatomic, strong) NMLocationApiModel *location;

+ (NSArray *)placesForModels:(NSArray *)models;

@end
