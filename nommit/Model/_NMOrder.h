// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMOrder.h instead.

#import <CoreData/CoreData.h>


extern const struct NMOrderAttributes {
	__unsafe_unretained NSString *deliveryAddress;
	__unsafe_unretained NSString *deliveryNote;
	__unsafe_unretained NSString *placedAt;
	__unsafe_unretained NSString *priceInCents;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *uid;
} NMOrderAttributes;

extern const struct NMOrderRelationships {
	__unsafe_unretained NSString *food;
	__unsafe_unretained NSString *user;
} NMOrderRelationships;

extern const struct NMOrderFetchedProperties {
} NMOrderFetchedProperties;

@class NMFood;
@class NMUser;








@interface NMOrderID : NSManagedObjectID {}
@end

@interface _NMOrder : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMOrderID*)objectID;





@property (nonatomic, strong) NSString* deliveryAddress;



//- (BOOL)validateDeliveryAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* deliveryNote;



//- (BOOL)validateDeliveryNote:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* placedAt;



//- (BOOL)validatePlacedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* priceInCents;



@property int64_t priceInCentsValue;
- (int64_t)priceInCentsValue;
- (void)setPriceInCentsValue:(int64_t)value_;

//- (BOOL)validatePriceInCents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* state;



@property int16_t stateValue;
- (int16_t)stateValue;
- (void)setStateValue:(int16_t)value_;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMFood *food;

//- (BOOL)validateFood:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _NMOrder (CoreDataGeneratedAccessors)

@end

@interface _NMOrder (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDeliveryAddress;
- (void)setPrimitiveDeliveryAddress:(NSString*)value;




- (NSString*)primitiveDeliveryNote;
- (void)setPrimitiveDeliveryNote:(NSString*)value;




- (NSDate*)primitivePlacedAt;
- (void)setPrimitivePlacedAt:(NSDate*)value;




- (NSNumber*)primitivePriceInCents;
- (void)setPrimitivePriceInCents:(NSNumber*)value;

- (int64_t)primitivePriceInCentsValue;
- (void)setPrimitivePriceInCentsValue:(int64_t)value_;




- (NSNumber*)primitiveState;
- (void)setPrimitiveState:(NSNumber*)value;

- (int16_t)primitiveStateValue;
- (void)setPrimitiveStateValue:(int16_t)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NMFood*)primitiveFood;
- (void)setPrimitiveFood:(NMFood*)value;



- (NMUser*)primitiveUser;
- (void)setPrimitiveUser:(NMUser*)value;


@end
