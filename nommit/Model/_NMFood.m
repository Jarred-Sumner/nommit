// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.m instead.

#import "_NMFood.h"

const struct NMFoodAttributes NMFoodAttributes = {
	.details = @"details",
	.endDate = @"endDate",
	.headerImageURL = @"headerImageURL",
	.orderCount = @"orderCount",
	.orderGoal = @"orderGoal",
	.price = @"price",
	.rawState = @"rawState",
	.subtitle = @"subtitle",
	.thumbnailImageURL = @"thumbnailImageURL",
	.title = @"title",
	.uid = @"uid",
};

const struct NMFoodRelationships NMFoodRelationships = {
	.orders = @"orders",
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
	if ([key isEqualToString:@"rawStateValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rawState"];
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




@dynamic details;






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





@dynamic price;






@dynamic rawState;



- (int16_t)rawStateValue {
	NSNumber *result = [self rawState];
	return [result shortValue];
}

- (void)setRawStateValue:(int16_t)value_ {
	[self setRawState:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRawStateValue {
	NSNumber *result = [self primitiveRawState];
	return [result shortValue];
}

- (void)setPrimitiveRawStateValue:(int16_t)value_ {
	[self setPrimitiveRawState:[NSNumber numberWithShort:value_]];
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





@dynamic orders;

	
- (NSMutableSet*)ordersSet {
	[self willAccessValueForKey:@"orders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"orders"];
  
	[self didAccessValueForKey:@"orders"];
	return result;
}
	






@end
