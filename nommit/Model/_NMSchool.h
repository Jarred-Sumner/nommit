// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSchool.h instead.

#import <CoreData/CoreData.h>


extern const struct NMSchoolAttributes {
	__unsafe_unretained NSString *fromHours;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *toHours;
	__unsafe_unretained NSString *uid;
} NMSchoolAttributes;

extern const struct NMSchoolRelationships {
	__unsafe_unretained NSString *users;
} NMSchoolRelationships;

extern const struct NMSchoolFetchedProperties {
} NMSchoolFetchedProperties;

@class NMUser;






@interface NMSchoolID : NSManagedObjectID {}
@end

@interface _NMSchool : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMSchoolID*)objectID;





@property (nonatomic, strong) NSDate* fromHours;



//- (BOOL)validateFromHours:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* toHours;



//- (BOOL)validateToHours:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMUser *users;

//- (BOOL)validateUsers:(id*)value_ error:(NSError**)error_;





@end

@interface _NMSchool (CoreDataGeneratedAccessors)

@end

@interface _NMSchool (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveFromHours;
- (void)setPrimitiveFromHours:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSDate*)primitiveToHours;
- (void)setPrimitiveToHours:(NSDate*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;





- (NMUser*)primitiveUsers;
- (void)setPrimitiveUsers:(NMUser*)value;


@end
