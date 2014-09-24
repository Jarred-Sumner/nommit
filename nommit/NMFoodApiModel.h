//
//  NMFoodApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Overcoat.h>
#import "NMApi.h"

@class NMSellerApiModel;

@interface NMFoodApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSString *headerImageURL;
@property (nonatomic, strong) NSString *thumbnailImageURL;
@property (nonatomic, strong) NSNumber *orderGoal;
@property (nonatomic, strong) NSNumber *orderCount;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *stateID;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NMSellerApiModel *seller;

- (BOOL)isActive;

@end
