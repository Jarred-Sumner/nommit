//
//  NMUserApiModel.h
//  nommit
//
//  Created by Jarred Sumner on 9/6/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Overcoat.h>

@interface NMUserApiModel : MTLModel <MTLJSONSerializing, MTLManagedObjectSerializing>

@property (nonatomic, strong) NSString *facebookUID;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *fullName;

@property (nonatomic, strong) NSNumber *referralCredit;
@property (nonatomic, strong) NSString *referralCode;

@property (nonatomic, strong) NSNumber *isCourier;

@property (nonatomic, strong) NSNumber *lastFour;
@property (nonatomic, strong) NSString *cardType;
@property (nonatomic, strong) NSNumber *paymentAuthorized;

@end
