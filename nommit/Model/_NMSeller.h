// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSeller.h instead.

@import CoreData;

extern const struct NMSellerAttributes {
	__unsafe_unretained NSString *logoURL;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *uid;
} NMSellerAttributes;

extern const struct NMSellerRelationships {
	__unsafe_unretained NSString *couriers;
	__unsafe_unretained NSString *foods;
} NMSellerRelationships;

@class NMCourier;
@class NMFood;

@interface NMSellerID : NSManagedObjectID {}
@end

@interface _NMSeller : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NMSellerID* objectID;

@property (nonatomic, strong) NSString* logoURL;

//- (BOOL)validateLogoURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* uid;

@property (atomic) int32_t uidValue;
- (int32_t)uidValue;
- (void)setUidValue:(int32_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *couriers;

- (NSMutableSet*)couriersSet;

@property (nonatomic, strong) NSSet *foods;

- (NSMutableSet*)foodsSet;

@end

@interface _NMSeller (CouriersCoreDataGeneratedAccessors)
- (void)addCouriers:(NSSet*)value_;
- (void)removeCouriers:(NSSet*)value_;
- (void)addCouriersObject:(NMCourier*)value_;
- (void)removeCouriersObject:(NMCourier*)value_;

@end

@interface _NMSeller (FoodsCoreDataGeneratedAccessors)
- (void)addFoods:(NSSet*)value_;
- (void)removeFoods:(NSSet*)value_;
- (void)addFoodsObject:(NMFood*)value_;
- (void)removeFoodsObject:(NMFood*)value_;

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

- (NSMutableSet*)primitiveCouriers;
- (void)setPrimitiveCouriers:(NSMutableSet*)value;

- (NSMutableSet*)primitiveFoods;
- (void)setPrimitiveFoods:(NSMutableSet*)value;

@end
