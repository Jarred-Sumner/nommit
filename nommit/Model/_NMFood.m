// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.m instead.

#import "_NMFood.h"

const struct NMFoodAttributes NMFoodAttributes = {
	.details = @"details",
	.endDate = @"endDate",
	.headerImageURL = @"headerImageURL",
	.orderCount = @"orderCount",
	.orderGoal = @"orderGoal",
	.rating = @"rating",
	.startDate = @"startDate",
	.stateID = @"stateID",
	.subtitle = @"subtitle",
	.thumbnailImageURL = @"thumbnailImageURL",
	.title = @"title",
	.uid = @"uid",
};

const struct NMFoodRelationships NMFoodRelationships = {
	.deliveryPlaces = @"deliveryPlaces",
	.orders = @"orders",
	.prices = @"prices",
	.seller = @"seller",
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
	if ([key isEqualToString:@"ratingValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"rating"];
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





@dynamic rating;



- (float)ratingValue {
	NSNumber *result = [self rating];
	return [result floatValue];
}

- (void)setRatingValue:(float)value_ {
	[self setRating:[NSNumber numberWithFloat:value_]];
}

- (float)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result floatValue];
}

- (void)setPrimitiveRatingValue:(float)value_ {
	[self setPrimitiveRating:[NSNumber numberWithFloat:value_]];
}





@dynamic startDate;






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





@dynamic deliveryPlaces;

	
- (NSMutableSet*)deliveryPlacesSet {
	[self willAccessValueForKey:@"deliveryPlaces"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"deliveryPlaces"];
  
	[self didAccessValueForKey:@"deliveryPlaces"];
	return result;
}
	

@dynamic orders;

	
- (NSMutableSet*)ordersSet {
	[self willAccessValueForKey:@"orders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"orders"];
  
	[self didAccessValueForKey:@"orders"];
	return result;
}
	

@dynamic prices;

	
- (NSMutableOrderedSet*)pricesSet {
	[self willAccessValueForKey:@"prices"];
  
	NSMutableOrderedSet *result = (NSMutableOrderedSet*)[self mutableOrderedSetValueForKey:@"prices"];
  
	[self didAccessValueForKey:@"prices"];
	return result;
}
	

@dynamic seller;

	






@end
