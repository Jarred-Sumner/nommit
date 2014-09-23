// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMPlace.h instead.

#import <CoreData/CoreData.h>


extern const struct NMPlaceAttributes {
	__unsafe_unretained NSString *foodCount;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *uid;
} NMPlaceAttributes;

extern const struct NMPlaceRelationships {
	__unsafe_unretained NSString *foods;
	__unsafe_unretained NSString *location;
} NMPlaceRelationships;

extern const struct NMPlaceFetchedProperties {
} NMPlaceFetchedProperties;

@class NMFood;
@class NMLocation;





@interface NMPlaceID : NSManagedObjectID {}
@end

@interface _NMPlace : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMPlaceID*)objectID;





@property (nonatomic, strong) NSNumber* foodCount;



@property int32_t foodCountValue;
- (int32_t)foodCountValue;
- (void)setFoodCountValue:(int32_t)value_;

//- (BOOL)validateFoodCount:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int32_t uidValue;
- (int32_t)uidValue;
- (void)setUidValue:(int32_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *foods;

- (NSMutableSet*)foodsSet;




@property (nonatomic, strong) NMLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;





@end

@interface _NMPlace (CoreDataGeneratedAccessors)

- (void)addFoods:(NSSet*)value_;
- (void)removeFoods:(NSSet*)value_;
- (void)addFoodsObject:(NMFood*)value_;
- (void)removeFoodsObject:(NMFood*)value_;

@end

@interface _NMPlace (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveFoodCount;
- (void)setPrimitiveFoodCount:(NSNumber*)value;

- (int32_t)primitiveFoodCountValue;
- (void)setPrimitiveFoodCountValue:(int32_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int32_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int32_t)value_;





- (NSMutableSet*)primitiveFoods;
- (void)setPrimitiveFoods:(NSMutableSet*)value;



- (NMLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(NMLocation*)value;


@end
