// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSeller.h instead.

#import <CoreData/CoreData.h>


extern const struct NMSellerAttributes {
	__unsafe_unretained NSString *logoURL;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *uid;
} NMSellerAttributes;

extern const struct NMSellerRelationships {
	__unsafe_unretained NSString *foods;
	__unsafe_unretained NSString *users;
} NMSellerRelationships;

extern const struct NMSellerFetchedProperties {
} NMSellerFetchedProperties;

@class NMFood;
@class NMUser;





@interface NMSellerID : NSManagedObjectID {}
@end

@interface _NMSeller : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMSellerID*)objectID;





@property (nonatomic, strong) NSString* logoURL;



//- (BOOL)validateLogoURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int32_t uidValue;
- (int32_t)uidValue;
- (void)setUidValue:(int32_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMFood *foods;

//- (BOOL)validateFoods:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *users;

- (NSMutableSet*)usersSet;





@end

@interface _NMSeller (CoreDataGeneratedAccessors)

- (void)addUsers:(NSSet*)value_;
- (void)removeUsers:(NSSet*)value_;
- (void)addUsersObject:(NMUser*)value_;
- (void)removeUsersObject:(NMUser*)value_;

@end

@interface _NMSeller (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLogoURL;
- (void)setPrimitiveLogoURL:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int32_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int32_t)value_;





- (NMFood*)primitiveFoods;
- (void)setPrimitiveFoods:(NMFood*)value;



- (NSMutableSet*)primitiveUsers;
- (void)setPrimitiveUsers:(NSMutableSet*)value;


@end
