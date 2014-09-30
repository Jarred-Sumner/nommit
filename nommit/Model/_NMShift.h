// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMShift.h instead.

#import <CoreData/CoreData.h>


extern const struct NMShiftAttributes {
	__unsafe_unretained NSString *places;
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *uid;
} NMShiftAttributes;

extern const struct NMShiftRelationships {
	__unsafe_unretained NSString *courier;
	__unsafe_unretained NSString *deliveryPlaces;
} NMShiftRelationships;

extern const struct NMShiftFetchedProperties {
} NMShiftFetchedProperties;

@class NMCourier;
@class NMDeliveryPlace;





@interface NMShiftID : NSManagedObjectID {}
@end

@interface _NMShift : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMShiftID*)objectID;





@property (nonatomic, strong) NSString* places;



//- (BOOL)validatePlaces:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* stateID;



@property int64_t stateIDValue;
- (int64_t)stateIDValue;
- (void)setStateIDValue:(int64_t)value_;

//- (BOOL)validateStateID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMCourier *courier;

//- (BOOL)validateCourier:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *deliveryPlaces;

- (NSMutableSet*)deliveryPlacesSet;





@end

@interface _NMShift (CoreDataGeneratedAccessors)

- (void)addDeliveryPlaces:(NSSet*)value_;
- (void)removeDeliveryPlaces:(NSSet*)value_;
- (void)addDeliveryPlacesObject:(NMDeliveryPlace*)value_;
- (void)removeDeliveryPlacesObject:(NMDeliveryPlace*)value_;

@end

@interface _NMShift (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitivePlaces;
- (void)setPrimitivePlaces:(NSString*)value;




- (NSNumber*)primitiveStateID;
- (void)setPrimitiveStateID:(NSNumber*)value;

- (int64_t)primitiveStateIDValue;
- (void)setPrimitiveStateIDValue:(int64_t)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NMCourier*)primitiveCourier;
- (void)setPrimitiveCourier:(NMCourier*)value;



- (NSMutableSet*)primitiveDeliveryPlaces;
- (void)setPrimitiveDeliveryPlaces:(NSMutableSet*)value;


@end
