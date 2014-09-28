// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMPlace.h instead.

#import <CoreData/CoreData.h>


extern const struct NMPlaceAttributes {
	__unsafe_unretained NSString *foodCount;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *uid;
} NMPlaceAttributes;

extern const struct NMPlaceRelationships {
	__unsafe_unretained NSString *couriers;
	__unsafe_unretained NSString *foodDeliveryPlaces;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *orders;
} NMPlaceRelationships;

extern const struct NMPlaceFetchedProperties {
} NMPlaceFetchedProperties;

@class NMCourier;
@class NMFoodDeliveryPlace;
@class NMLocation;
@class NMOrder;





@interface NMPlaceID : NSManagedObjectID {}
@end

@interface _NMPlace : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMPlaceID*)objectID;





@property (nonatomic, strong) NSNumber* foodCount;



@property int32_t foodCountValue;
- (int32_t)foodCountValue;
- (void)setFoodCountValue:(int32_t)value_;

//- (BOOL)validateFoodCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int32_t uidValue;
- (int32_t)uidValue;
- (void)setUidValue:(int32_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *couriers;

- (NSMutableSet*)couriersSet;




@property (nonatomic, strong) NSSet *foodDeliveryPlaces;

- (NSMutableSet*)foodDeliveryPlacesSet;




@property (nonatomic, strong) NMLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;





@end

@interface _NMPlace (CoreDataGeneratedAccessors)

- (void)addCouriers:(NSSet*)value_;
- (void)removeCouriers:(NSSet*)value_;
- (void)addCouriersObject:(NMCourier*)value_;
- (void)removeCouriersObject:(NMCourier*)value_;

- (void)addFoodDeliveryPlaces:(NSSet*)value_;
- (void)removeFoodDeliveryPlaces:(NSSet*)value_;
- (void)addFoodDeliveryPlacesObject:(NMFoodDeliveryPlace*)value_;
- (void)removeFoodDeliveryPlacesObject:(NMFoodDeliveryPlace*)value_;

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





- (NSMutableSet*)primitiveCouriers;
- (void)setPrimitiveCouriers:(NSMutableSet*)value;



- (NSMutableSet*)primitiveFoodDeliveryPlaces;
- (void)setPrimitiveFoodDeliveryPlaces:(NSMutableSet*)value;



- (NMLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(NMLocation*)value;



- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;


@end
