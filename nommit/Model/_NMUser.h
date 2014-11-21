// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMUser.h instead.

#import <CoreData/CoreData.h>


extern const struct NMUserAttributes {
	__unsafe_unretained NSString *cardType;
	__unsafe_unretained NSString *creditInCents;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *facebookUID;
	__unsafe_unretained NSString *fullName;
	__unsafe_unretained NSString *isCourier;
	__unsafe_unretained NSString *lastFour;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *paymentAuthorized;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *referralCode;
	__unsafe_unretained NSString *stateID;
} NMUserAttributes;

extern const struct NMUserRelationships {
	__unsafe_unretained NSString *couriers;
	__unsafe_unretained NSString *locations;
	__unsafe_unretained NSString *notification;
	__unsafe_unretained NSString *orders;
	__unsafe_unretained NSString *subscription;
} NMUserRelationships;

extern const struct NMUserFetchedProperties {
} NMUserFetchedProperties;

@class NMCourier;
@class NMLocation;
@class NMUser;
@class NMOrder;
@class NMSubscription;














@interface NMUserID : NSManagedObjectID {}
@end

@interface _NMUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMUserID*)objectID;





@property (nonatomic, strong) NSString* cardType;



//- (BOOL)validateCardType:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* creditInCents;



@property int64_t creditInCentsValue;
- (int64_t)creditInCentsValue;
- (void)setCreditInCentsValue:(int64_t)value_;

//- (BOOL)validateCreditInCents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* facebookUID;



//- (BOOL)validateFacebookUID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* fullName;



//- (BOOL)validateFullName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isCourier;



@property BOOL isCourierValue;
- (BOOL)isCourierValue;
- (void)setIsCourierValue:(BOOL)value_;

//- (BOOL)validateIsCourier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastFour;



//- (BOOL)validateLastFour:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* paymentAuthorized;



@property BOOL paymentAuthorizedValue;
- (BOOL)paymentAuthorizedValue;
- (void)setPaymentAuthorizedValue:(BOOL)value_;

//- (BOOL)validatePaymentAuthorized:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phone;



//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* referralCode;



//- (BOOL)validateReferralCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* stateID;



@property int16_t stateIDValue;
- (int16_t)stateIDValue;
- (void)setStateIDValue:(int16_t)value_;

//- (BOOL)validateStateID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *couriers;

- (NSMutableSet*)couriersSet;




@property (nonatomic, strong) NMLocation *locations;

//- (BOOL)validateLocations:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMUser *notification;

//- (BOOL)validateNotification:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;




@property (nonatomic, strong) NMSubscription *subscription;

//- (BOOL)validateSubscription:(id*)value_ error:(NSError**)error_;





@end

@interface _NMUser (CoreDataGeneratedAccessors)

- (void)addCouriers:(NSSet*)value_;
- (void)removeCouriers:(NSSet*)value_;
- (void)addCouriersObject:(NMCourier*)value_;
- (void)removeCouriersObject:(NMCourier*)value_;

- (void)addOrders:(NSSet*)value_;
- (void)removeOrders:(NSSet*)value_;
- (void)addOrdersObject:(NMOrder*)value_;
- (void)removeOrdersObject:(NMOrder*)value_;

@end

@interface _NMUser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCardType;
- (void)setPrimitiveCardType:(NSString*)value;




- (NSNumber*)primitiveCreditInCents;
- (void)setPrimitiveCreditInCents:(NSNumber*)value;

- (int64_t)primitiveCreditInCentsValue;
- (void)setPrimitiveCreditInCentsValue:(int64_t)value_;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFacebookUID;
- (void)setPrimitiveFacebookUID:(NSString*)value;




- (NSString*)primitiveFullName;
- (void)setPrimitiveFullName:(NSString*)value;




- (NSNumber*)primitiveIsCourier;
- (void)setPrimitiveIsCourier:(NSNumber*)value;

- (BOOL)primitiveIsCourierValue;
- (void)setPrimitiveIsCourierValue:(BOOL)value_;




- (NSString*)primitiveLastFour;
- (void)setPrimitiveLastFour:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitivePaymentAuthorized;
- (void)setPrimitivePaymentAuthorized:(NSNumber*)value;

- (BOOL)primitivePaymentAuthorizedValue;
- (void)setPrimitivePaymentAuthorizedValue:(BOOL)value_;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;




- (NSString*)primitiveReferralCode;
- (void)setPrimitiveReferralCode:(NSString*)value;




- (NSNumber*)primitiveStateID;
- (void)setPrimitiveStateID:(NSNumber*)value;

- (int16_t)primitiveStateIDValue;
- (void)setPrimitiveStateIDValue:(int16_t)value_;





- (NSMutableSet*)primitiveCouriers;
- (void)setPrimitiveCouriers:(NSMutableSet*)value;



- (NMLocation*)primitiveLocations;
- (void)setPrimitiveLocations:(NMLocation*)value;



- (NMUser*)primitiveNotification;
- (void)setPrimitiveNotification:(NMUser*)value;



- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;



- (NMSubscription*)primitiveSubscription;
- (void)setPrimitiveSubscription:(NMSubscription*)value;


@end
