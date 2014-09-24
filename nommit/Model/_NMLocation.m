// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMLocation.m instead.

#import "_NMLocation.h"

const struct NMLocationAttributes NMLocationAttributes = {
	.addressOne = @"addressOne",
	.addressTwo = @"addressTwo",
	.city = @"city",
	.country = @"country",
	.instructions = @"instructions",
	.latitude = @"latitude",
	.longitude = @"longitude",
	.name = @"name",
	.phone = @"phone",
	.state = @"state",
	.uid = @"uid",
	.zip = @"zip",
};

const struct NMLocationRelationships NMLocationRelationships = {
	.place = @"place",
	.user = @"user",
};

const struct NMLocationFetchedProperties NMLocationFetchedProperties = {
};

@implementation NMLocationID
@end

@implementation _NMLocation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMLocation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMLocation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMLocation" inManagedObjectContext:moc_];
}

- (NMLocationID*)objectID {
	return (NMLocationID*)[super objectID];
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






@dynamic latitude;






@dynamic longitude;






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






@dynamic place;

	

@dynamic user;

	






@end
