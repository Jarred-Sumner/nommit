//
//  NMApi.h
//  nommit
//
//  Created by Jarred Sumner on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import <Overcoat.h>

#import "NMFoodApiModel.h"
#import "NMOrderApiModel.h"
#import "NMUserApiModel.h"
#import "NMLocationApiModel.h"
#import "NMPlaceApiModel.h"
#import "NMSellerApiModel.h"
#import "NMErrorApiModel.h"
#import "NMCourierApiModel.h"
#import "NMShiftApiModel.h"
#import "NMDeliveryPlaceApiModel.h"
#import "NMPriceApiModel.h"

#import "NMPrice.h"
#import "NMLocation.h"
#import "NMFood.h"
#import "NMorder.h"
#import "NMUser.h"
#import "NMPlace.h"
#import "NMSeller.h"
#import "NMCourier.h"
#import "NMShift.h"
#import "NMDeliveryPlace.h"

#import "NMSession.h"

typedef void (^NMApiCompletionBlock)(id response, NSError *error);

@interface NMApi : OVCHTTPSessionManager

//@property (nonatomic, strong) NSManagedObjectContext *context;

+ (void)resetInstance;
+ (NMApi *)instance;
+ (NSDateFormatter *)dateFormatter;

- (NSURLSessionDataTask*)POST:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion;
- (NSURLSessionDataTask*)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion;
- (NSURLSessionDataTask*)GET:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion;
- (NSURLSessionDataTask*)HEAD:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion;
- (NSURLSessionDataTask*)PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion;

@end
