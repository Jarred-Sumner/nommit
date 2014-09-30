// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMDeliveryPlace.m instead.

#import "_NMDeliveryPlace.h"

const struct NMDeliveryPlaceAttributes NMDeliveryPlaceAttributes = {
	.arrivesAt = @"arrivesAt",
	.index = @"index",
	.stateID = @"stateID",
	.uid = @"uid",
};

const struct NMDeliveryPlaceRelationships NMDeliveryPlaceRelationships = {
	.foods = @"foods",
	.place = @"place",
	.shift = @"shift",
};

const struct NMDeliveryPlaceFetchedProperties NMDeliveryPlaceFetchedProperties = {
};

@implementation NMDeliveryPlaceID
@end

@implementation _NMDeliveryPlace

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMDeliveryPlace" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMDeliveryPlace";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMDeliveryPlace" inManagedObjectContext:moc_];
}

- (NMDeliveryPlaceID*)objectID {
	return (NMDeliveryPlaceID*)[super objectID];
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

	return keyPaths;
}




@dynamic arrivesAt;






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





@dynamic foods;

	
- (NSMutableSet*)foodsSet {
	[self willAccessValueForKey:@"foods"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"foods"];
  
	[self didAccessValueForKey:@"foods"];
	return result;
}
	

@dynamic place;

	

@dynamic shift;

	






@end
