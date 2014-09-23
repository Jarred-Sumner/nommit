// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMPlace.m instead.

#import "_NMPlace.h"

const struct NMPlaceAttributes NMPlaceAttributes = {
	.foodCount = @"foodCount",
	.name = @"name",
	.uid = @"uid",
};

const struct NMPlaceRelationships NMPlaceRelationships = {
	.foods = @"foods",
	.location = @"location",
};

const struct NMPlaceFetchedProperties NMPlaceFetchedProperties = {
};

@implementation NMPlaceID
@end

@implementation _NMPlace

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMPlace" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMPlace";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMPlace" inManagedObjectContext:moc_];
}

- (NMPlaceID*)objectID {
	return (NMPlaceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"foodCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"foodCount"];
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




@dynamic foodCount;



- (int32_t)foodCountValue {
	NSNumber *result = [self foodCount];
	return [result intValue];
}

- (void)setFoodCountValue:(int32_t)value_ {
	[self setFoodCount:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveFoodCountValue {
	NSNumber *result = [self primitiveFoodCount];
	return [result intValue];
}

- (void)setPrimitiveFoodCountValue:(int32_t)value_ {
	[self setPrimitiveFoodCount:[NSNumber numberWithInt:value_]];
}





@dynamic name;






@dynamic uid;



- (int32_t)uidValue {
	NSNumber *result = [self uid];
	return [result intValue];
}

- (void)setUidValue:(int32_t)value_ {
	[self setUid:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveUidValue {
	NSNumber *result = [self primitiveUid];
	return [result intValue];
}

- (void)setPrimitiveUidValue:(int32_t)value_ {
	[self setPrimitiveUid:[NSNumber numberWithInt:value_]];
}





@dynamic foods;

	
- (NSMutableSet*)foodsSet {
	[self willAccessValueForKey:@"foods"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"foods"];
  
	[self didAccessValueForKey:@"foods"];
	return result;
}
	

@dynamic location;

	






@end
