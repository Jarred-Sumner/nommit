// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMDeliveryPlace.h instead.

#import <CoreData/CoreData.h>


extern const struct NMDeliveryPlaceAttributes {
	__unsafe_unretained NSString *arrivesAt;
	__unsafe_unretained NSString *index;
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *uid;
} NMDeliveryPlaceAttributes;

extern const struct NMDeliveryPlaceRelationships {
	__unsafe_unretained NSString *foods;
	__unsafe_unretained NSString *orders;
	__unsafe_unretained NSString *place;
	__unsafe_unretained NSString *shift;
} NMDeliveryPlaceRelationships;

extern const struct NMDeliveryPlaceFetchedProperties {
} NMDeliveryPlaceFetchedProperties;

@class NMFood;
@class NMOrder;
@class NMPlace;
@class NMShift;






@interface NMDeliveryPlaceID : NSManagedObjectID {}
@end

@interface _NMDeliveryPlace : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMDeliveryPlaceID*)objectID;





@property (nonatomic, strong) NSDate* arrivesAt;



//- (BOOL)validateArrivesAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* index;



@property int16_t indexValue;
- (int16_t)indexValue;
- (void)setIndexValue:(int16_t)value_;

//- (BOOL)validateIndex:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* stateID;



@property int16_t stateIDValue;
- (int16_t)stateIDValue;
- (void)setStateIDValue:(int16_t)value_;

//- (BOOL)validateStateID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *foods;

- (NSMutableSet*)foodsSet;




@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;




@property (nonatomic, strong) NMPlace *place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMShift *shift;

//- (BOOL)validateShift:(id*)value_ error:(NSError**)error_;





@end

@interface _NMDeliveryPlace (CoreDataGeneratedAccessors)

- (void)addFoods:(NSSet*)value_;
- (void)removeFoods:(NSSet*)value_;
- (void)addFoodsObject:(NMFood*)value_;
- (void)removeFoodsObject:(NMFood*)value_;

- (void)addOrders:(NSSet*)value_;
- (void)removeOrders:(NSSet*)value_;
- (void)addOrdersObject:(NMOrder*)value_;
- (void)removeOrdersObject:(NMOrder*)value_;

@end

@interface _NMDeliveryPlace (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveArrivesAt;
- (void)setPrimitiveArrivesAt:(NSDate*)value;




- (NSNumber*)primitiveIndex;
- (void)setPrimitiveIndex:(NSNumber*)value;

- (int16_t)primitiveIndexValue;
- (void)setPrimitiveIndexValue:(int16_t)value_;




- (NSNumber*)primitiveStateID;
- (void)setPrimitiveStateID:(NSNumber*)value;

- (int16_t)primitiveStateIDValue;
- (void)setPrimitiveStateIDValue:(int16_t)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NSMutableSet*)primitiveFoods;
- (void)setPrimitiveFoods:(NSMutableSet*)value;



- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;



- (NMPlace*)primitivePlace;
- (void)setPrimitivePlace:(NMPlace*)value;



- (NMShift*)primitiveShift;
- (void)setPrimitiveShift:(NMShift*)value;


@end
