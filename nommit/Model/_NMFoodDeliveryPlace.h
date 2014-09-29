// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFoodDeliveryPlace.h instead.

#import <CoreData/CoreData.h>


extern const struct NMFoodDeliveryPlaceAttributes {
	__unsafe_unretained NSString *eta;
	__unsafe_unretained NSString *index;
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *uid;
	__unsafe_unretained NSString *waitInterval;
} NMFoodDeliveryPlaceAttributes;

extern const struct NMFoodDeliveryPlaceRelationships {
	__unsafe_unretained NSString *courier;
	__unsafe_unretained NSString *food;
	__unsafe_unretained NSString *place;
} NMFoodDeliveryPlaceRelationships;

extern const struct NMFoodDeliveryPlaceFetchedProperties {
} NMFoodDeliveryPlaceFetchedProperties;

@class NMCourier;
@class NMFood;
@class NMPlace;







@interface NMFoodDeliveryPlaceID : NSManagedObjectID {}
@end

@interface _NMFoodDeliveryPlace : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMFoodDeliveryPlaceID*)objectID;





@property (nonatomic, strong) NSDate* eta;



//- (BOOL)validateEta:(id*)value_ error:(NSError**)error_;





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





@property (nonatomic, strong) NSNumber* waitInterval;



@property int32_t waitIntervalValue;
- (int32_t)waitIntervalValue;
- (void)setWaitIntervalValue:(int32_t)value_;

//- (BOOL)validateWaitInterval:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMCourier *courier;

//- (BOOL)validateCourier:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMFood *food;

//- (BOOL)validateFood:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMPlace *place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;





@end

@interface _NMFoodDeliveryPlace (CoreDataGeneratedAccessors)

@end

@interface _NMFoodDeliveryPlace (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveEta;
- (void)setPrimitiveEta:(NSDate*)value;




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




- (NSNumber*)primitiveWaitInterval;
- (void)setPrimitiveWaitInterval:(NSNumber*)value;

- (int32_t)primitiveWaitIntervalValue;
- (void)setPrimitiveWaitIntervalValue:(int32_t)value_;





- (NMCourier*)primitiveCourier;
- (void)setPrimitiveCourier:(NMCourier*)value;



- (NMFood*)primitiveFood;
- (void)setPrimitiveFood:(NMFood*)value;



- (NMPlace*)primitivePlace;
- (void)setPrimitivePlace:(NMPlace*)value;


@end
