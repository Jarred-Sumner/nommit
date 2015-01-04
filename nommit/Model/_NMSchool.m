// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSchool.m instead.

#import "_NMSchool.h"

const struct NMSchoolAttributes NMSchoolAttributes = {
	.fromHours = @"fromHours",
	.imageURL = @"imageURL",
	.motd = @"motd",
	.motdExpiration = @"motdExpiration",
	.name = @"name",
	.toHours = @"toHours",
	.uid = @"uid",
};

const struct NMSchoolRelationships NMSchoolRelationships = {
	.places = @"places",
	.sellers = @"sellers",
	.users = @"users",
};

@implementation NMSchoolID
@end

@implementation _NMSchool

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMSchool" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMSchool";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMSchool" inManagedObjectContext:moc_];
}

- (NMSchoolID*)objectID {
	return (NMSchoolID*)[super objectID];
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

@dynamic fromHours;

@dynamic imageURL;

@dynamic motd;

@dynamic motdExpiration;

@dynamic name;

@dynamic toHours;

@dynamic uid;

- (int64_t)uidValue {
	NSNumber *result = [self uid];
	return [result longLongValue];
}

- (void)setUidValue:(int64_t)value_ {
	[self setUid:@(value_)];
}

- (int64_t)primitiveUidValue {
	NSNumber *result = [self primitiveUid];
	return [result longLongValue];
}

- (void)setPrimitiveUidValue:(int64_t)value_ {
	[self setPrimitiveUid:@(value_)];
}

@dynamic places;

- (NSMutableSet*)placesSet {
	[self willAccessValueForKey:@"places"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"places"];

	[self didAccessValueForKey:@"places"];
	return result;
}

@dynamic sellers;

- (NSMutableSet*)sellersSet {
	[self willAccessValueForKey:@"sellers"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"sellers"];

	[self didAccessValueForKey:@"sellers"];
	return result;
}

@dynamic users;

@end

