//
//  NMUserApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Blah Labs, Inc. All rights reserved.
//

#import <Overcoat.h>

@class NMSchoolApiModel;

@interface NMUserApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSString *facebookUID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSNumber *creditInCents;
@property (nonatomic, strong) NSString *referralCode;

@property (nonatomic, strong) NSNumber *isCourier;

@property (nonatomic, strong) NSNumber *lastFour;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSNumber *paymentAuthorized;
@property (nonatomic, strong) NSNumber *stateID;

@property (nonatomic, strong) NMSchoolApiModel *school;

@end
