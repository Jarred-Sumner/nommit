// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.h instead.

#import <CoreData/CoreData.h>


extern const struct NMFoodAttributes {
	__unsafe_unretained NSString *endDate;
	__unsafe_unretained NSString *headerImageURL;
	__unsafe_unretained NSString *orderCount;
	__unsafe_unretained NSString *orderGoal;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *subtitle;
	__unsafe_unretained NSString *thumbnailImageURL;
	__unsafe_unretained NSString *title;
	__unsafe_unretained NSString *uid;
} NMFoodAttributes;

extern const struct NMFoodRelationships {
} NMFoodRelationships;

extern const struct NMFoodFetchedProperties {
} NMFoodFetchedProperties;












@interface NMFoodID : NSManagedObjectID {}
@end

@interface _NMFood : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMFoodID*)objectID;





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





@property (nonatomic, strong) NSNumber* state;



@property int16_t stateValue;
- (int16_t)stateValue;
- (void)setStateValue:(int16_t)value_;

//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





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






@end

@interface _NMFood (CoreDataGeneratedAccessors)

@end

@interface _NMFood (CoreDataGeneratedPrimitiveAccessors)


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




- (NSNumber*)primitiveState;
- (void)setPrimitiveState:(NSNumber*)value;

- (int16_t)primitiveStateValue;
- (void)setPrimitiveStateValue:(int16_t)value_;




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




@end
