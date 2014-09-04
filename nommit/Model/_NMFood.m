// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.m instead.

#import "_NMFood.h"

const struct NMFoodAttributes NMFoodAttributes = {
	.endDate = @"endDate",
	.headerImageURL = @"headerImageURL",
	.orderCount = @"orderCount",
	.orderGoal = @"orderGoal",
	.state = @"state",
	.subtitle = @"subtitle",
	.thumbnailImageURL = @"thumbnailImageURL",
	.title = @"title",
	.uid = @"uid",
};

const struct NMFoodRelationships NMFoodRelationships = {
};

const struct NMFoodFetchedProperties NMFoodFetchedProperties = {
};

@implementation NMFoodID
@end

@implementation _NMFood

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMFood" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMFood";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMFood" inManagedObjectContext:moc_];
}

- (NMFoodID*)objectID {
	return (NMFoodID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"orderCountValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"orderCount"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"orderGoalValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"orderGoal"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"stateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"state"];
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




@dynamic endDate;






@dynamic headerImageURL;






@dynamic orderCount;



- (int16_t)orderCountValue {
	NSNumber *result = [self orderCount];
	return [result shortValue];
}

- (void)setOrderCountValue:(int16_t)value_ {
	[self setOrderCount:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveOrderCountValue {
	NSNumber *result = [self primitiveOrderCount];
	return [result shortValue];
}

- (void)setPrimitiveOrderCountValue:(int16_t)value_ {
	[self setPrimitiveOrderCount:[NSNumber numberWithShort:value_]];
}





@dynamic orderGoal;



- (int16_t)orderGoalValue {
	NSNumber *result = [self orderGoal];
	return [result shortValue];
}

- (void)setOrderGoalValue:(int16_t)value_ {
	[self setOrderGoal:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveOrderGoalValue {
	NSNumber *result = [self primitiveOrderGoal];
	return [result shortValue];
}

- (void)setPrimitiveOrderGoalValue:(int16_t)value_ {
	[self setPrimitiveOrderGoal:[NSNumber numberWithShort:value_]];
}





@dynamic state;



- (int16_t)stateValue {
	NSNumber *result = [self state];
	return [result shortValue];
}

- (void)setStateValue:(int16_t)value_ {
	[self setState:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveStateValue {
	NSNumber *result = [self primitiveState];
	return [result shortValue];
}

- (void)setPrimitiveStateValue:(int16_t)value_ {
	[self setPrimitiveState:[NSNumber numberWithShort:value_]];
}





@dynamic subtitle;






@dynamic thumbnailImageURL;






@dynamic title;






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










@end
