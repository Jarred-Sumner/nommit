// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMPrice.h instead.

#import <CoreData/CoreData.h>


extern const struct NMPriceAttributes {
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *quantity;
	__unsafe_unretained NSString *uid;
} NMPriceAttributes;

extern const struct NMPriceRelationships {
	__unsafe_unretained NSString *food;
} NMPriceRelationships;

extern const struct NMPriceFetchedProperties {
} NMPriceFetchedProperties;

@class NMFood;





@interface NMPriceID : NSManagedObjectID {}
@end

@interface _NMPrice : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMPriceID*)objectID;





@property (nonatomic, strong) NSDecimalNumber* price;



//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* quantity;



@property int16_t quantityValue;
- (int16_t)quantityValue;
- (void)setQuantityValue:(int16_t)value_;

//- (BOOL)validateQuantity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMFood *food;

//- (BOOL)validateFood:(id*)value_ error:(NSError**)error_;





@end

@interface _NMPrice (CoreDataGeneratedAccessors)

@end

@interface _NMPrice (CoreDataGeneratedPrimitiveAccessors)


- (NSDecimalNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSDecimalNumber*)value;




- (NSNumber*)primitiveQuantity;
- (void)setPrimitiveQuantity:(NSNumber*)value;

- (int16_t)primitiveQuantityValue;
- (void)setPrimitiveQuantityValue:(int16_t)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NMFood*)primitiveFood;
- (void)setPrimitiveFood:(NMFood*)value;


@end
