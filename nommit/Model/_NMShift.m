// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMShift.m instead.

#import "_NMShift.h"

const struct NMShiftAttributes NMShiftAttributes = {
	.places = @"places",
	.stateID = @"stateID",
	.uid = @"uid",
};

const struct NMShiftRelationships NMShiftRelationships = {
	.courier = @"courier",
	.deliveryPlaces = @"deliveryPlaces",
};

const struct NMShiftFetchedProperties NMShiftFetchedProperties = {
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






@dynamic stateID;



- (int64_t)stateIDValue {
	NSNumber *result = [self stateID];
	return [result longLongValue];
}

- (void)setStateIDValue:(int64_t)value_ {
	[self setStateID:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveStateIDValue {
	NSNumber *result = [self primitiveStateID];
	return [result longLongValue];
}

- (void)setPrimitiveStateIDValue:(int64_t)value_ {
	[self setPrimitiveStateID:[NSNumber numberWithLongLong:value_]];
}





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





@dynamic courier;

	

@dynamic deliveryPlaces;

	
- (NSMutableSet*)deliveryPlacesSet {
	[self willAccessValueForKey:@"deliveryPlaces"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"deliveryPlaces"];
  
	[self didAccessValueForKey:@"deliveryPlaces"];
	return result;
}
	






@end