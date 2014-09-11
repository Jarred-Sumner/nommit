// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMAddress.h instead.

#import <CoreData/CoreData.h>


extern const struct NMAddressAttributes {
	__unsafe_unretained NSString *addressOne;
	__unsafe_unretained NSString *addressTwo;
	__unsafe_unretained NSString *city;
	__unsafe_unretained NSString *country;
	__unsafe_unretained NSString *instructions;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *phone;
	__unsafe_unretained NSString *state;
	__unsafe_unretained NSString *uid;
	__unsafe_unretained NSString *zip;
} NMAddressAttributes;

extern const struct NMAddressRelationships {
	__unsafe_unretained NSString *order;
	__unsafe_unretained NSString *user;
} NMAddressRelationships;

extern const struct NMAddressFetchedProperties {
} NMAddressFetchedProperties;

@class NMOrder;
@class NMUser;












@interface NMAddressID : NSManagedObjectID {}
@end

@interface _NMAddress : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (NMAddressID*)objectID;





@property (nonatomic, strong) NSString* addressOne;



//- (BOOL)validateAddressOne:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* addressTwo;



//- (BOOL)validateAddressTwo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* city;



//- (BOOL)validateCity:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* country;



//- (BOOL)validateCountry:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* instructions;



//- (BOOL)validateInstructions:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* phone;



//- (BOOL)validatePhone:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* state;



//- (BOOL)validateState:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* uid;



@property int64_t uidValue;
- (int64_t)uidValue;
- (void)setUidValue:(int64_t)value_;

//- (BOOL)validateUid:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* zip;



//- (BOOL)validateZip:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NMOrder *order;

//- (BOOL)validateOrder:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NMUser *user;

//- (BOOL)validateUser:(id*)value_ error:(NSError**)error_;





@end

@interface _NMAddress (CoreDataGeneratedAccessors)

@end

@interface _NMAddress (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddressOne;
- (void)setPrimitiveAddressOne:(NSString*)value;




- (NSString*)primitiveAddressTwo;
- (void)setPrimitiveAddressTwo:(NSString*)value;




- (NSString*)primitiveCity;
- (void)setPrimitiveCity:(NSString*)value;




- (NSString*)primitiveCountry;
- (void)setPrimitiveCountry:(NSString*)value;




- (NSString*)primitiveInstructions;
- (void)setPrimitiveInstructions:(NSString*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSString*)primitivePhone;
- (void)setPrimitivePhone:(NSString*)value;




- (NSString*)primitiveState;
- (void)setPrimitiveState:(NSString*)value;




- (NSNumber*)primitiveUid;
- (void)setPrimitiveUid:(NSNumber*)value;

- (int64_t)primitiveUidValue;
- (void)setPrimitiveUidValue:(int64_t)value_;




- (NSString*)primitiveZip;
- (void)setPrimitiveZip:(NSString*)value;





- (NMOrder*)primitiveOrder;
- (void)setPrimitiveOrder:(NMOrder*)value;



- (NMUser*)primitiveUser;
- (void)setPrimitiveUser:(NMUser*)value;


@end
