// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMCourier.h instead.

#import <CoreData/CoreData.h>


extern const struct NMCourierAttributes {
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *uid;
} NMCourierAttributes;

extern const struct NMCourierRelationships {
	__unsafe_unretained NSString *orders;
	__unsafe_unretained NSString *seller;
	__unsafe_unretained NSString *shifts;
	__unsafe_unretained NSString *user;
} NMCourierRelationships;

extern const struct NMCourierFetchedProperties {
} NMCourierFetchedProperties;

@class NMOrder;
@class NMSeller;
@class NMShift;
@class NMUser;




@interface NMCourierID : NSManagedObjectID {}
@end

@interface _NMCourier : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMCourierID*)objectID;





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





@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;




@property (nonatomic, strong) NMSeller *seller;

//- (BOOL)validateSeller:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *shifts;

- (NSMutableSet*)shiftsSet;




@property (nonatomic, strong) NMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _NMCourier (CoreDataGeneratedAccessors)

- (void)addOrders:(NSSet*)value_;
- (void)removeOrders:(NSSet*)value_;
- (void)addOrdersObject:(NMOrder*)value_;
- (void)removeOrdersObject:(NMOrder*)value_;

- (void)addShifts:(NSSet*)value_;
- (void)removeShifts:(NSSet*)value_;
- (void)addShiftsObject:(NMShift*)value_;
- (void)removeShiftsObject:(NMShift*)value_;

@end

@interface _NMCourier (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveStateID;
- (void)setPrimitiveStateID:(NSNumber*)value;

- (int16_t)primitiveStateIDValue;
- (void)setPrimitiveStateIDValue:(int16_t)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;



- (NMSeller*)primitiveSeller;
- (void)setPrimitiveSeller:(NMSeller*)value;



- (NSMutableSet*)primitiveShifts;
- (void)setPrimitiveShifts:(NSMutableSet*)value;



- (NMUser*)primitiveUser;
- (void)setPrimitiveUser:(NMUser*)value;


@end
