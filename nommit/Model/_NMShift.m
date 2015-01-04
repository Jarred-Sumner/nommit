// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMShift.m instead.

#import "_NMShift.h"

const struct NMShiftAttributes NMShiftAttributes = {
	.places = @"places",
	.revenueGeneratedInCents = @"revenueGeneratedInCents",
	.stateID = @"stateID",
	.uid = @"uid",
};

const struct NMShiftRelationships NMShiftRelationships = {
	.courier = @"courier",
	.deliveryPlaces = @"deliveryPlaces",
};

@implementation NMShiftID
@end

@implementation _NMShift

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMShift" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMShift";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMShift" inManagedObjectContext:moc_];
}

- (NMShiftID*)objectID {
	return (NMShiftID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"revenueGeneratedInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"revenueGeneratedInCents"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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

@dynamic places;

@dynamic revenueGeneratedInCents;

- (int64_t)revenueGeneratedInCentsValue {
	NSNumber *result = [self revenueGeneratedInCents];
	return [result longLongValue];
}

- (void)setRevenueGeneratedInCentsValue:(int64_t)value_ {
	[self setRevenueGeneratedInCents:@(value_)];
}

- (int64_t)primitiveRevenueGeneratedInCentsValue {
	NSNumber *result = [self primitiveRevenueGeneratedInCents];
	return [result longLongValue];
}

- (void)setPrimitiveRevenueGeneratedInCentsValue:(int64_t)value_ {
	[self setPrimitiveRevenueGeneratedInCents:@(value_)];
}

@dynamic stateID;

- (int64_t)stateIDValue {
	NSNumber *result = [self stateID];
	return [result longLongValue];
}

- (void)setStateIDValue:(int64_t)value_ {
	[self setStateID:@(value_)];
}

- (int64_t)primitiveStateIDValue {
	NSNumber *result = [self primitiveStateID];
	return [result longLongValue];
}

- (void)setPrimitiveStateIDValue:(int64_t)value_ {
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

@dynamic courier;

@dynamic deliveryPlaces;

- (NSMutableSet*)deliveryPlacesSet {
	[self willAccessValueForKey:@"deliveryPlaces"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"deliveryPlaces"];

	[self didAccessValueForKey:@"deliveryPlaces"];
	return result;
}

@end

