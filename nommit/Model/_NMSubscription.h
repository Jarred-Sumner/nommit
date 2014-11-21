// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSubscription.h instead.

#import <CoreData/CoreData.h>


extern const struct NMSubscriptionAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *pushNotifications;
	__unsafe_unretained NSString *sms;
	__unsafe_unretained NSString *uid;
} NMSubscriptionAttributes;

extern const struct NMSubscriptionRelationships {
	__unsafe_unretained NSString *user;
} NMSubscriptionRelationships;

extern const struct NMSubscriptionFetchedProperties {
} NMSubscriptionFetchedProperties;

@class NMUser;






@interface NMSubscriptionID : NSManagedObjectID {}
@end

@interface _NMSubscription : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMSubscriptionID*)objectID;





@property (nonatomic, strong) NSNumber* email;



@property BOOL emailValue;
- (BOOL)emailValue;
- (void)setEmailValue:(BOOL)value_;

//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* pushNotifications;



@property BOOL pushNotificationsValue;
- (BOOL)pushNotificationsValue;
- (void)setPushNotificationsValue:(BOOL)value_;

//- (BOOL)validatePushNotifications:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* sms;



@property BOOL smsValue;
- (BOOL)smsValue;
- (void)setSmsValue:(BOOL)value_;

//- (BOOL)validateSms:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _NMSubscription (CoreDataGeneratedAccessors)

@end

@interface _NMSubscription (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveEmail;
- (void)setPrimitiveEmail:(NSNumber*)value;

- (BOOL)primitiveEmailValue;
- (void)setPrimitiveEmailValue:(BOOL)value_;




- (NSNumber*)primitivePushNotifications;
- (void)setPrimitivePushNotifications:(NSNumber*)value;

- (BOOL)primitivePushNotificationsValue;
- (void)setPrimitivePushNotificationsValue:(BOOL)value_;




- (NSNumber*)primitiveSms;
- (void)setPrimitiveSms:(NSNumber*)value;

- (BOOL)primitiveSmsValue;
- (void)setPrimitiveSmsValue:(BOOL)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NMUser*)primitiveUser;
- (void)setPrimitiveUser:(NMUser*)value;


@end
