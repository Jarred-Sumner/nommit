// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMPlace.h instead.

@import CoreData;

extern const struct NMPlaceAttributes {
	__unsafe_unretained NSString *foodCount;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *uid;
} NMPlaceAttributes;

extern const struct NMPlaceRelationships {
	__unsafe_unretained NSString *deliveryPlaces;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *orders;
} NMPlaceRelationships;

@class NMDeliveryPlace;
@class NMLocation;
@class NMOrder;

@interface NMPlaceID : NSManagedObjectID {}
@end

@interface _NMPlace : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) NMPlaceID* objectID;

@property (nonatomic, strong) NSNumber* foodCount;

@property (atomic) int32_t foodCountValue;
- (int32_t)foodCountValue;
- (void)setFoodCountValue:(int32_t)value_;

//- (BOOL)validateFoodCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* uid;

@property (atomic) int32_t uidValue;
- (int32_t)uidValue;
- (void)setUidValue:(int32_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *deliveryPlaces;

- (NSMutableSet*)deliveryPlacesSet;

@property (nonatomic, strong) NMLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;

@end

@interface _NMPlace (DeliveryPlacesCoreDataGeneratedAccessors)
- (void)addDeliveryPlaces:(NSSet*)value_;
- (void)removeDeliveryPlaces:(NSSet*)value_;
- (void)addDeliveryPlacesObject:(NMDeliveryPlace*)value_;
- (void)removeDeliveryPlacesObject:(NMDeliveryPlace*)value_;

@end

@interface _NMPlace (OrdersCoreDataGeneratedAccessors)
- (void)addOrders:(NSSet*)value_;
- (void)removeOrders:(NSSet*)value_;
- (void)addOrdersObject:(NMOrder*)value_;
- (void)removeOrdersObject:(NMOrder*)value_;

@end

@interface _NMPlace (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveFoodCount;
- (void)setPrimitiveFoodCount:(NSNumber*)value;

- (int32_t)primitiveFoodCountValue;
- (void)setPrimitiveFoodCountValue:(int32_t)value_;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int32_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int32_t)value_;

- (NSMutableSet*)primitiveDeliveryPlaces;
- (void)setPrimitiveDeliveryPlaces:(NSMutableSet*)value;

- (NMLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(NMLocation*)value;

- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;

@end
