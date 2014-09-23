//
//  NMAddressApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Overcoat.h>

@interface NMLocationApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSNumber *uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *addressOne;
@property (nonatomic, strong) NSString *addressTwo;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;
@property (nonatomic, strong) NSString *instructions;
@property (nonatomic, strong) NSDecimalNumber *latitude;
@property (nonatomic, strong) NSDecimalNumber *longitude;


@end
