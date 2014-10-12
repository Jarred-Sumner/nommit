//
//  NMPriceApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 10/11/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "MTLModel.h"

@interface NMPriceApiModel : MTLModel <MTLManagedObjectSerializing, MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *quantity;

@end
