//
//  NMApi.m
//  nommit
//
//  Created by Jarred Sumner on 9/3/14.
//  Copyright (c) 2014 Lucy Guo. All rights reserved.
//

#import "NMApi.h"
#import "NMErrorApiModel.h"

@interface NMApi ()
@end

static id sharedApi;
static NSString *NMApiBaseURLString = API_URL;

@implementation NMApi

+ (NSURLSessionConfiguration *)sessionConfiguration {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSMutableDictionary *headers = [[NSMutableDictionary alloc] init];
    headers[@"X-APP-VERSION"] = appVersion;
    headers[@"X-APP-PLATFORM"] = @"iOS";
    
    if ([NMSession isUserLoggedIn]) {
        headers[@"X-SESSION-ID"] = NMSession.sessionID;
    }
    
    sessionConfig.HTTPAdditionalHeaders = headers;
    return sessionConfig;
}

- (instancetype)init {
    self = [super initWithBaseURL:[NSURL URLWithString:NMApiBaseURLString] managedObjectContext:nil sessionConfiguration:[NMApi sessionConfiguration]];
    return self;
}

+ (NMApi *)instance {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedApi = [[NMApi alloc] init];
    });
    return sharedApi;
}

+ (void)resetInstance {
    sharedApi = [[NMApi alloc] init];
}

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"users/*" : [NMUserApiModel class],
             @"couriers/me" : [NMCourierApiModel class],
             @"users/*/promos" : [NMUserApiModel class],
             @"sessions" : [NMUserApiModel class],
             @"orders" : [NMOrderApiModel class],
             @"orders/*" : [NMOrderApiModel class],
             @"foods" : [NMFoodApiModel class],
             @"places": [NMPlaceApiModel class],
             @"places/*": [NMPlaceApiModel class],
             @"places/*/orders" : [NMOrderApiModel class],
             @"orders/*" : [NMOrderApiModel class],
             @"shifts" : [NMShiftApiModel class],
             @"shifts/*" : [NMShiftApiModel class],
             @"delivery_places/*": [NMDeliveryPlaceApiModel class]
     };
}

+ (Class)errorModelClass { return [NMErrorApiModel class]; }

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
     return dateFormatter;
}

#pragma mark - Persistence

+ (NMApiCompletionBlock)completionBlockWithPersistence:(NMApiCompletionBlock)completion {
    return ^(id response, NSError *error) {
        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
        if (completion) completion(response, error);
    };
}

- (NSURLSessionDataTask*)POST:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion {
    return [super POST:URLString parameters:parameters completion:[[self class] completionBlockWithPersistence:completion]];
}

- (NSURLSessionDataTask*)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion {
    return [super PUT:URLString parameters:parameters completion:[[self class] completionBlockWithPersistence:completion]];
}

- (NSURLSessionDataTask*)GET:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion {
    return [super GET:URLString parameters:parameters completion:[[self class] completionBlockWithPersistence:completion]];
    
}

- (NSURLSessionDataTask*)HEAD:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion {
    return [super HEAD:URLString parameters:parameters completion:[[self class] completionBlockWithPersistence:completion]];
}

- (NSURLSessionDataTask*)PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(void (^)(id, NSError *))completion {
    return [super PATCH:URLString parameters:parameters completion:[[self class] completionBlockWithPersistence:completion]];
}

#pragma mark - Error Handling

+ (NMApiCompletionBlock)completionWithErrorHandling:(NMApiCompletionBlock)completion {
    return ^(id response, NSError *error) {
        if ([[response result] class] == [NMErrorApiModel class]) {
            [[response result] handleError];
        } else if (error) {
            [NMErrorApiModel handleGenericError];
        } else {
            if (completion) completion(response, error);
        }
        
    };
}

- (NSURLSessionDataTask*)POST:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion {
    return [self POST:URLString parameters:parameters completion:[NMApi completionWithErrorHandling:completion]];
}

- (NSURLSessionDataTask*)PUT:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion {
    return [self PUT:URLString parameters:parameters completion:[NMApi completionWithErrorHandling:completion]];
}

- (NSURLSessionDataTask*)GET:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion {
    return [self GET:URLString parameters:parameters completion:[NMApi completionWithErrorHandling:completion]];
}

- (NSURLSessionDataTask*)HEAD:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion {
    return [self HEAD:URLString parameters:parameters completion:[NMApi completionWithErrorHandling:completion]];
}

- (NSURLSessionDataTask*)PATCH:(NSString *)URLString parameters:(NSDictionary *)parameters completionWithErrorHandling:(void (^)(id, NSError *))completion {
    return [self PATCH:URLString parameters:parameters completion:[NMApi completionWithErrorHandling:completion]];
}

@end
