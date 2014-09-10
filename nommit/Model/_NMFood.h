// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.h instead.

#import <CoreData/CoreData.h>


extern const struct NMFoodAttributes {
	__unsafe_unretained NSString *details;
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *headerImageURL;
	__unsafe_unretained NSString *orderCount;
	__unsafe_unretained NSString *orderGoal;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *rawState;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *thumbnailImageURL;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *uid;
} NMFoodAttributes;

extern const struct NMFoodRelationships {
	__unsafe_unretained NSString *orders;
} NMFoodRelationships;

extern const struct NMFoodFetchedProperties {
} NMFoodFetchedProperties;

@class NMOrder;













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





@property (nonatomic, strong) NSDecimalNumber* price;



//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* rawState;



@property int16_t rawStateValue;
- (int16_t)rawStateValue;
- (void)setRawStateValue:(int16_t)value_;

//- (BOOL)validateRawState:(id*)value_ error:(NSError**)error_;





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





@property (nonatomic, strong) NSSet *orders;

- (NSMutableSet*)ordersSet;





@end

@interface _NMFood (CoreDataGeneratedAccessors)

- (void)addOrders:(NSSet*)value_;
- (void)removeOrders:(NSSet*)value_;
- (void)addOrdersObject:(NMOrder*)value_;
- (void)removeOrdersObject:(NMOrder*)value_;

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




- (NSDecimalNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSDecimalNumber*)value;




- (NSNumber*)primitiveRawState;
- (void)setPrimitiveRawState:(NSNumber*)value;

- (int16_t)primitiveRawStateValue;
- (void)setPrimitiveRawStateValue:(int16_t)value_;




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





- (NSMutableSet*)primitiveOrders;
- (void)setPrimitiveOrders:(NSMutableSet*)value;


@end
