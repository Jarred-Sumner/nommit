// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMCourier.m instead.

#import "_NMCourier.h"

const struct NMCourierAttributes NMCourierAttributes = {
	.stateID = @"stateID",
	.uid = @"uid",
};

const struct NMCourierRelationships NMCourierRelationships = {
	.orders = @"orders",
	.seller = @"seller",
	.shifts = @"shifts",
	.user = @"user",
};

@implementation NMCourierID
@end

@implementation _NMCourier

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMCourier" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMCourier";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMCourier" inManagedObjectContext:moc_];
}

- (NMCourierID*)objectID {
	return (NMCourierID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"stateIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stateID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic stateID;

- (int16_t)stateIDValue {
	NSNumber *result = [self stateID];
	return [result shortValue];
}

- (void)setStateIDValue:(int16_t)value_ {
	[self setStateID:@(value_)];
}

- (int16_t)primitiveStateIDValue {
	NSNumber *result = [self primitiveStateID];
	return [result shortValue];
}

- (void)setPrimitiveStateIDValue:(int16_t)value_ {
	[self setPrimitiveStateID:@(value_)];
}

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

@dynamic orders;

- (NSMutableSet*)ordersSet {
	[self willAccessValueForKey:@"orders"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"orders"];

	[self didAccessValueForKey:@"orders"];
	return result;
}

@dynamic seller;

@dynamic shifts;

- (NSMutableSet*)shiftsSet {
	[self willAccessValueForKey:@"shifts"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"shifts"];

	[self didAccessValueForKey:@"shifts"];
	return result;
}

@dynamic user;

@end

