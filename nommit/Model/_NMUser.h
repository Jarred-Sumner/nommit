// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMUser.h instead.

#import <CoreData/CoreData.h>


extern const struct NMUserAttributes {
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *facebookUID;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
} NMUserAttributes;

extern const struct NMUserRelationships {
	__unsafe_unretained NSString *addresses;
	__unsafe_unretained NSString *orders;
} NMUserRelationships;

extern const struct NMUserFetchedProperties {
} NMUserFetchedProperties;

@class NMAddress;
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





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phone;



//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMAddress *addresses;

//- (BOOL)validateAddresses:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;





@end

@interface _NMUser (CoreDataGeneratedAccessors)

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




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;





- (NMAddress*)primitiveAddresses;
- (void)setPrimitiveAddresses:(NMAddress*)value;



- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;


@end
