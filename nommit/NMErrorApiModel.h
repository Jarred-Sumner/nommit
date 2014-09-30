//
//  NMErrorApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/23/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "MTLModel.h"

@interface NMErrorApiModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSString *message;

+ (void)handleGenericError;
- (void)handleError;

@end
