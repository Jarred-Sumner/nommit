// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFoodDeliveryPlace.m instead.

#import "_NMFoodDeliveryPlace.h"

const struct NMFoodDeliveryPlaceAttributes NMFoodDeliveryPlaceAttributes = {
	.index = @"index",
	.stateID = @"stateID",
	.uid = @"uid",
	.waitInterval = @"waitInterval",
};

const struct NMFoodDeliveryPlaceRelationships NMFoodDeliveryPlaceRelationships = {
	.courier = @"courier",
	.food = @"food",
	.place = @"place",
};

const struct NMFoodDeliveryPlaceFetchedProperties NMFoodDeliveryPlaceFetchedProperties = {
};

@implementation NMFoodDeliveryPlaceID
@end

@implementation _NMFoodDeliveryPlace

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMFoodDeliveryPlace" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMFoodDeliveryPlace";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMFoodDeliveryPlace" inManagedObjectContext:moc_];
}

- (NMFoodDeliveryPlaceID*)objectID {
	return (NMFoodDeliveryPlaceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
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
	if ([key isEqualToString:@"waitIntervalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"waitInterval"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic index;



- (int16_t)indexValue {
	NSNumber *result = [self index];
	return [result shortValue];
}

- (void)setIndexValue:(int16_t)value_ {
	[self setIndex:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result shortValue];
}

- (void)setPrimitiveIndexValue:(int16_t)value_ {
	[self setPrimitiveIndex:[NSNumber numberWithShort:value_]];
}





@dynamic stateID;



- (int16_t)stateIDValue {
	NSNumber *result = [self stateID];
	return [result shortValue];
}

- (void)setStateIDValue:(int16_t)value_ {
	[self setStateID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveStateIDValue {
	NSNumber *result = [self primitiveStateID];
	return [result shortValue];
}

- (void)setPrimitiveStateIDValue:(int16_t)value_ {
	[self setPrimitiveStateID:[NSNumber numberWithShort:value_]];
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





@dynamic waitInterval;



- (int32_t)waitIntervalValue {
	NSNumber *result = [self waitInterval];
	return [result intValue];
}

- (void)setWaitIntervalValue:(int32_t)value_ {
	[self setWaitInterval:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveWaitIntervalValue {
	NSNumber *result = [self primitiveWaitInterval];
	return [result intValue];
}

- (void)setPrimitiveWaitIntervalValue:(int32_t)value_ {
	[self setPrimitiveWaitInterval:[NSNumber numberWithInt:value_]];
}





@dynamic courier;

	

@dynamic food;

	

@dynamic place;

	






@end
