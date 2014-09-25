// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSeller.h instead.

#import <CoreData/CoreData.h>


extern const struct NMSellerAttributes {
	__unsafe_unretained NSString *logoURL;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *uid;
} NMSellerAttributes;

extern const struct NMSellerRelationships {
	__unsafe_unretained NSString *couriers;
	__unsafe_unretained NSString *foods;
} NMSellerRelationships;

extern const struct NMSellerFetchedProperties {
} NMSellerFetchedProperties;

@class NMCourier;
@class NMFood;





@interface NMSellerID : NSManagedObjectID {}
@end

@interface _NMSeller : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMSellerID*)objectID;





@property (nonatomic, strong) NSString* logoURL;



//- (BOOL)validateLogoURL:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int32_t uidValue;
- (int32_t)uidValue;
- (void)setUidValue:(int32_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMCourier *couriers;

//- (BOOL)validateCouriers:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet *foods;

- (NSMutableSet*)foodsSet;





@end

@interface _NMSeller (CoreDataGeneratedAccessors)

- (void)addFoods:(NSSet*)value_;
- (void)removeFoods:(NSSet*)value_;
- (void)addFoodsObject:(NMFood*)value_;
- (void)removeFoodsObject:(NMFood*)value_;

@end

@interface _NMSeller (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveLogoURL;
- (void)setPrimitiveLogoURL:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int32_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int32_t)value_;





- (NMCourier*)primitiveCouriers;
- (void)setPrimitiveCouriers:(NMCourier*)value;



- (NSMutableSet*)primitiveFoods;
- (void)setPrimitiveFoods:(NSMutableSet*)value;


@end
