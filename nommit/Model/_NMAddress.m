// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMAddress.m instead.

#import "_NMAddress.h"

const struct NMAddressAttributes NMAddressAttributes = {
	.addressOne = @"addressOne",
	.addressTwo = @"addressTwo",
	.city = @"city",
	.country = @"country",
	.instructions = @"instructions",
	.name = @"name",
	.phone = @"phone",
	.state = @"state",
	.uid = @"uid",
	.zip = @"zip",
};

const struct NMAddressRelationships NMAddressRelationships = {
	.order = @"order",
	.user = @"user",
};

const struct NMAddressFetchedProperties NMAddressFetchedProperties = {
};

@implementation NMAddressID
@end

@implementation _NMAddress

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMAddress" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMAddress";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMAddress" inManagedObjectContext:moc_];
}

- (NMAddressID*)objectID {
	return (NMAddressID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic addressOne;






@dynamic addressTwo;






@dynamic city;






@dynamic country;






@dynamic instructions;






@dynamic name;






@dynamic phone;






@dynamic state;






@dynamic uid;



- (int64_t)uidValue {
	NSNumber *result = [self uid];
	return [result longLongValue];
}

- (void)setUidValue:(int64_t)value_ {
	[self setUid:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveUidValue {
	NSNumber *result = [self primitiveUid];
	return [result longLongValue];
}

- (void)setPrimitiveUidValue:(int64_t)value_ {
	[self setPrimitiveUid:[NSNumber numberWithLongLong:value_]];
}





@dynamic zip;






@dynamic order;

	

@dynamic user;

	






@end
