// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMOrder.h instead.

#import <CoreData/CoreData.h>


extern const struct NMOrderAttributes {
	__unsafe_unretained NSString *chargeStateID;
	__unsafe_unretained NSString *deliveredAt;
	__unsafe_unretained NSString *discountInCents;
	__unsafe_unretained NSString *placedAt;
	__unsafe_unretained NSString *priceInCents;
	__unsafe_unretained NSString *promoCode;
	__unsafe_unretained NSString *quantity;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *tipInCents;
	__unsafe_unretained NSString *uid;
} NMOrderAttributes;

extern const struct NMOrderRelationships {
	__unsafe_unretained NSString *courier;
	__unsafe_unretained NSString *food;
	__unsafe_unretained NSString *place;
	__unsafe_unretained NSString *user;
} NMOrderRelationships;

extern const struct NMOrderFetchedProperties {
} NMOrderFetchedProperties;

@class NMCourier;
@class NMFood;
@class NMPlace;
@class NMUser;













@interface NMOrderID : NSManagedObjectID {}
@end

@interface _NMOrder : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMOrderID*)objectID;





@property (nonatomic, strong) NSNumber* chargeStateID;



@property int16_t chargeStateIDValue;
- (int16_t)chargeStateIDValue;
- (void)setChargeStateIDValue:(int16_t)value_;

//- (BOOL)validateChargeStateID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* deliveredAt;



//- (BOOL)validateDeliveredAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* discountInCents;



@property int64_t discountInCentsValue;
- (int64_t)discountInCentsValue;
- (void)setDiscountInCentsValue:(int64_t)value_;

//- (BOOL)validateDiscountInCents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* placedAt;



//- (BOOL)validatePlacedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* priceInCents;



@property int64_t priceInCentsValue;
- (int64_t)priceInCentsValue;
- (void)setPriceInCentsValue:(int64_t)value_;

//- (BOOL)validatePriceInCents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* promoCode;



//- (BOOL)validatePromoCode:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* quantity;



@property int32_t quantityValue;
- (int32_t)quantityValue;
- (void)setQuantityValue:(int32_t)value_;

//- (BOOL)validateQuantity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rating;



@property float ratingValue;
- (float)ratingValue;
- (void)setRatingValue:(float)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* stateID;



@property int16_t stateIDValue;
- (int16_t)stateIDValue;
- (void)setStateIDValue:(int16_t)value_;

//- (BOOL)validateStateID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* tipInCents;



@property int64_t tipInCentsValue;
- (int64_t)tipInCentsValue;
- (void)setTipInCentsValue:(int64_t)value_;

//- (BOOL)validateTipInCents:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMCourier *courier;

//- (BOOL)validateCourier:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMFood *food;

//- (BOOL)validateFood:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMPlace *place;

//- (BOOL)validatePlace:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _NMOrder (CoreDataGeneratedAccessors)

@end

@interface _NMOrder (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveChargeStateID;
- (void)setPrimitiveChargeStateID:(NSNumber*)value;

- (int16_t)primitiveChargeStateIDValue;
- (void)setPrimitiveChargeStateIDValue:(int16_t)value_;




- (NSDate*)primitiveDeliveredAt;
- (void)setPrimitiveDeliveredAt:(NSDate*)value;




- (NSNumber*)primitiveDiscountInCents;
- (void)setPrimitiveDiscountInCents:(NSNumber*)value;

- (int64_t)primitiveDiscountInCentsValue;
- (void)setPrimitiveDiscountInCentsValue:(int64_t)value_;




- (NSDate*)primitivePlacedAt;
- (void)setPrimitivePlacedAt:(NSDate*)value;




- (NSNumber*)primitivePriceInCents;
- (void)setPrimitivePriceInCents:(NSNumber*)value;

- (int64_t)primitivePriceInCentsValue;
- (void)setPrimitivePriceInCentsValue:(int64_t)value_;




- (NSString*)primitivePromoCode;
- (void)setPrimitivePromoCode:(NSString*)value;




- (NSNumber*)primitiveQuantity;
- (void)setPrimitiveQuantity:(NSNumber*)value;

- (int32_t)primitiveQuantityValue;
- (void)setPrimitiveQuantityValue:(int32_t)value_;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (float)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(float)value_;




- (NSNumber*)primitiveStateID;
- (void)setPrimitiveStateID:(NSNumber*)value;

- (int16_t)primitiveStateIDValue;
- (void)setPrimitiveStateIDValue:(int16_t)value_;




- (NSNumber*)primitiveTipInCents;
- (void)setPrimitiveTipInCents:(NSNumber*)value;

- (int64_t)primitiveTipInCentsValue;
- (void)setPrimitiveTipInCentsValue:(int64_t)value_;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NMCourier*)primitiveCourier;
- (void)setPrimitiveCourier:(NMCourier*)value;



- (NMFood*)primitiveFood;
- (void)setPrimitiveFood:(NMFood*)value;



- (NMPlace*)primitivePlace;
- (void)setPrimitivePlace:(NMPlace*)value;



- (NMUser*)primitiveUser;
- (void)setPrimitiveUser:(NMUser*)value;


@end
