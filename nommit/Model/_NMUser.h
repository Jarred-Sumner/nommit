// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMUser.h instead.

#import <CoreData/CoreData.h>


extern const struct NMUserAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *facebookUID;
	__unsafe_unretained NSString *isCourier;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
} NMUserAttributes;

extern const struct NMUserRelationships {
	__unsafe_unretained NSString *couriers;
	__unsafe_unretained NSString *locations;
	__unsafe_unretained NSString *orders;
} NMUserRelationships;

extern const struct NMUserFetchedProperties {
} NMUserFetchedProperties;

@class NMCourier;
@class NMLocation;
@class NMOrder;







@interface NMUserID : NSManagedObjectID {}
@end

@interface _NMUser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMUserID*)objectID;





@property (nonatomic, strong) NSString* email;



//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* facebookUID;



//- (BOOL)validateFacebookUID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* isCourier;



@property BOOL isCourierValue;
- (BOOL)isCourierValue;
- (void)setIsCourierValue:(BOOL)value_;

//- (BOOL)validateIsCourier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phone;



//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *couriers;

- (NSMutableSet*)couriersSet;




@property (nonatomic, strong) NMLocation *locations;

//- (BOOL)validateLocations:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;





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


- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveFacebookUID;
- (void)setPrimitiveFacebookUID:(NSString*)value;




- (NSNumber*)primitiveIsCourier;
- (void)setPrimitiveIsCourier:(NSNumber*)value;

- (BOOL)primitiveIsCourierValue;
- (void)setPrimitiveIsCourierValue:(BOOL)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;





- (NSMutableSet*)primitiveCouriers;
- (void)setPrimitiveCouriers:(NSMutableSet*)value;



- (NMLocation*)primitiveLocations;
- (void)setPrimitiveLocations:(NMLocation*)value;



- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;


@end
