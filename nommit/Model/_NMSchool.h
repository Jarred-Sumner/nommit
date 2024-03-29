// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSchool.h instead.

@import CoreData;

extern const struct NMSchoolAttributes {
	__unsafe_unretained NSString *fromHours;
	__unsafe_unretained NSString *imageURL;
	__unsafe_unretained NSString *motd;
	__unsafe_unretained NSString *motdExpiration;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *toHours;
	__unsafe_unretained NSString *uid;
} NMSchoolAttributes;

extern const struct NMSchoolRelationships {
	__unsafe_unretained NSString *places;
	__unsafe_unretained NSString *sellers;
	__unsafe_unretained NSString *users;
} NMSchoolRelationships;

@class NMPlace;
@class NMSeller;
@class NMUser;

@interface NMSchoolID : NSManagedObjectID {}
@end

@interface _NMSchool : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NMSchoolID* objectID;

@property (nonatomic, strong) NSDate* fromHours;

//- (BOOL)validateFromHours:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageURL;

//- (BOOL)validateImageURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* motd;

//- (BOOL)validateMotd:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* motdExpiration;

//- (BOOL)validateMotdExpiration:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* toHours;

//- (BOOL)validateToHours:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* uid;

@property (atomic) int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *places;

- (NSMutableSet*)placesSet;

@property (nonatomic, strong) NSSet *sellers;

- (NSMutableSet*)sellersSet;

@property (nonatomic, strong) NMUser *users;

//- (BOOL)validateUsers:(id*)value_ error:(NSError**)error_;

@end

@interface _NMSchool (PlacesCoreDataGeneratedAccessors)
- (void)addPlaces:(NSSet*)value_;
- (void)removePlaces:(NSSet*)value_;
- (void)addPlacesObject:(NMPlace*)value_;
- (void)removePlacesObject:(NMPlace*)value_;

@end

@interface _NMSchool (SellersCoreDataGeneratedAccessors)
- (void)addSellers:(NSSet*)value_;
- (void)removeSellers:(NSSet*)value_;
- (void)addSellersObject:(NMSeller*)value_;
- (void)removeSellersObject:(NMSeller*)value_;

@end

@interface _NMSchool (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveFromHours;
- (void)setPrimitiveFromHours:(NSDate*)value;

- (NSString*)primitiveImageURL;
- (void)setPrimitiveImageURL:(NSString*)value;

- (NSString*)primitiveMotd;
- (void)setPrimitiveMotd:(NSString*)value;

- (NSDate*)primitiveMotdExpiration;
- (void)setPrimitiveMotdExpiration:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSDate*)primitiveToHours;
- (void)setPrimitiveToHours:(NSDate*)value;

- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;

- (NSMutableSet*)primitivePlaces;
- (void)setPrimitivePlaces:(NSMutableSet*)value;

- (NSMutableSet*)primitiveSellers;
- (void)setPrimitiveSellers:(NSMutableSet*)value;

- (NMUser*)primitiveUsers;
- (void)setPrimitiveUsers:(NMUser*)value;

@end
