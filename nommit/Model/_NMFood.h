// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.h instead.

#import <CoreData/CoreData.h>


extern const struct NMFoodAttributes {
	__unsafe_unretained NSString *details;
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *headerImageURL;
	__unsafe_unretained NSString *orderCount;
	__unsafe_unretained NSString *orderGoal;
	__unsafe_unretained NSString *rating;
	__unsafe_unretained NSString *startDate;
	__unsafe_unretained NSString *stateID;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *thumbnailImageURL;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *uid;
} NMFoodAttributes;

extern const struct NMFoodRelationships {
	__unsafe_unretained NSString *deliveryPlaces;
	__unsafe_unretained NSString *orders;
	__unsafe_unretained NSString *prices;
	__unsafe_unretained NSString *seller;
} NMFoodRelationships;

extern const struct NMFoodFetchedProperties {
} NMFoodFetchedProperties;

@class NMDeliveryPlace;
@class NMOrder;
@class NMPrice;
@class NMSeller;














@interface NMFoodID : NSManagedObjectID {}
@end

@interface _NMFood : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMFoodID*)objectID;





@property (nonatomic, strong) NSString* details;



//- (BOOL)validateDetails:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* endDate;



//- (BOOL)validateEndDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* headerImageURL;



//- (BOOL)validateHeaderImageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* orderCount;



@property int16_t orderCountValue;
- (int16_t)orderCountValue;
- (void)setOrderCountValue:(int16_t)value_;

//- (BOOL)validateOrderCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* orderGoal;



@property int16_t orderGoalValue;
- (int16_t)orderGoalValue;
- (void)setOrderGoalValue:(int16_t)value_;

//- (BOOL)validateOrderGoal:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rating;



@property float ratingValue;
- (float)ratingValue;
- (void)setRatingValue:(float)value_;

//- (BOOL)validateRating:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* startDate;



//- (BOOL)validateStartDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* stateID;



@property int16_t stateIDValue;
- (int16_t)stateIDValue;
- (void)setStateIDValue:(int16_t)value_;

//- (BOOL)validateStateID:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* subtitle;



//- (BOOL)validateSubtitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* thumbnailImageURL;



//- (BOOL)validateThumbnailImageURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* title;



//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *deliveryPlaces;

- (NSMutableSet*)deliveryPlacesSet;




@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;




@property (nonatomic, strong) NSOrderedSet *prices;

- (NSMutableOrderedSet*)pricesSet;




@property (nonatomic, strong) NMSeller *seller;

//- (BOOL)validateSeller:(id*)value_ error:(NSError**)error_;





@end

@interface _NMFood (CoreDataGeneratedAccessors)

- (void)addDeliveryPlaces:(NSSet*)value_;
- (void)removeDeliveryPlaces:(NSSet*)value_;
- (void)addDeliveryPlacesObject:(NMDeliveryPlace*)value_;
- (void)removeDeliveryPlacesObject:(NMDeliveryPlace*)value_;

- (void)addOrders:(NSSet*)value_;
- (void)removeOrders:(NSSet*)value_;
- (void)addOrdersObject:(NMOrder*)value_;
- (void)removeOrdersObject:(NMOrder*)value_;

- (void)addPrices:(NSOrderedSet*)value_;
- (void)removePrices:(NSOrderedSet*)value_;
- (void)addPricesObject:(NMPrice*)value_;
- (void)removePricesObject:(NMPrice*)value_;

@end

@interface _NMFood (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDetails;
- (void)setPrimitiveDetails:(NSString*)value;




- (NSDate*)primitiveEndDate;
- (void)setPrimitiveEndDate:(NSDate*)value;




- (NSString*)primitiveHeaderImageURL;
- (void)setPrimitiveHeaderImageURL:(NSString*)value;




- (NSNumber*)primitiveOrderCount;
- (void)setPrimitiveOrderCount:(NSNumber*)value;

- (int16_t)primitiveOrderCountValue;
- (void)setPrimitiveOrderCountValue:(int16_t)value_;




- (NSNumber*)primitiveOrderGoal;
- (void)setPrimitiveOrderGoal:(NSNumber*)value;

- (int16_t)primitiveOrderGoalValue;
- (void)setPrimitiveOrderGoalValue:(int16_t)value_;




- (NSNumber*)primitiveRating;
- (void)setPrimitiveRating:(NSNumber*)value;

- (float)primitiveRatingValue;
- (void)setPrimitiveRatingValue:(float)value_;




- (NSDate*)primitiveStartDate;
- (void)setPrimitiveStartDate:(NSDate*)value;




- (NSNumber*)primitiveStateID;
- (void)setPrimitiveStateID:(NSNumber*)value;

- (int16_t)primitiveStateIDValue;
- (void)setPrimitiveStateIDValue:(int16_t)value_;




- (NSString*)primitiveSubtitle;
- (void)setPrimitiveSubtitle:(NSString*)value;




- (NSString*)primitiveThumbnailImageURL;
- (void)setPrimitiveThumbnailImageURL:(NSString*)value;




- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NSMutableSet*)primitiveDeliveryPlaces;
- (void)setPrimitiveDeliveryPlaces:(NSMutableSet*)value;



- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;



- (NSMutableOrderedSet*)primitivePrices;
- (void)setPrimitivePrices:(NSMutableOrderedSet*)value;



- (NMSeller*)primitiveSeller;
- (void)setPrimitiveSeller:(NMSeller*)value;


@end
