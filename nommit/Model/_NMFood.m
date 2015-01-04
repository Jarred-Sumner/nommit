// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMFood.m instead.

#import "_NMFood.h"

const struct NMFoodAttributes NMFoodAttributes = {
	.details = @"details",
	.endDate = @"endDate",
	.featured = @"featured",
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
	.willNotifyUser = @"willNotifyUser",
};

const struct NMFoodRelationships NMFoodRelationships = {
	.deliveryPlaces = @"deliveryPlaces",
	.orders = @"orders",
	.prices = @"prices",
	.seller = @"seller",
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

	if ([key isEqualToString:@"featuredValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"featured"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
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
	if ([key isEqualToString:@"willNotifyUserValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"willNotifyUser"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic details;

@dynamic endDate;

@dynamic featured;

- (BOOL)featuredValue {
	NSNumber *result = [self featured];
	return [result boolValue];
}

- (void)setFeaturedValue:(BOOL)value_ {
	[self setFeatured:@(value_)];
}

- (BOOL)primitiveFeaturedValue {
	NSNumber *result = [self primitiveFeatured];
	return [result boolValue];
}

- (void)setPrimitiveFeaturedValue:(BOOL)value_ {
	[self setPrimitiveFeatured:@(value_)];
}

@dynamic headerImageURL;

@dynamic orderCount;

- (int16_t)orderCountValue {
	NSNumber *result = [self orderCount];
	return [result shortValue];
}

- (void)setOrderCountValue:(int16_t)value_ {
	[self setOrderCount:@(value_)];
}

- (int16_t)primitiveOrderCountValue {
	NSNumber *result = [self primitiveOrderCount];
	return [result shortValue];
}

- (void)setPrimitiveOrderCountValue:(int16_t)value_ {
	[self setPrimitiveOrderCount:@(value_)];
}

@dynamic orderGoal;

- (int16_t)orderGoalValue {
	NSNumber *result = [self orderGoal];
	return [result shortValue];
}

- (void)setOrderGoalValue:(int16_t)value_ {
	[self setOrderGoal:@(value_)];
}

- (int16_t)primitiveOrderGoalValue {
	NSNumber *result = [self primitiveOrderGoal];
	return [result shortValue];
}

- (void)setPrimitiveOrderGoalValue:(int16_t)value_ {
	[self setPrimitiveOrderGoal:@(value_)];
}

@dynamic rating;

- (float)ratingValue {
	NSNumber *result = [self rating];
	return [result floatValue];
}

- (void)setRatingValue:(float)value_ {
	[self setRating:@(value_)];
}

- (float)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result floatValue];
}

- (void)setPrimitiveRatingValue:(float)value_ {
	[self setPrimitiveRating:@(value_)];
}

@dynamic startDate;

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

@dynamic subtitle;

@dynamic thumbnailImageURL;

@dynamic title;

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

@dynamic willNotifyUser;

- (BOOL)willNotifyUserValue {
	NSNumber *result = [self willNotifyUser];
	return [result boolValue];
}

- (void)setWillNotifyUserValue:(BOOL)value_ {
	[self setWillNotifyUser:@(value_)];
}

- (BOOL)primitiveWillNotifyUserValue {
	NSNumber *result = [self primitiveWillNotifyUser];
	return [result boolValue];
}

- (void)setPrimitiveWillNotifyUserValue:(BOOL)value_ {
	[self setPrimitiveWillNotifyUser:@(value_)];
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

@implementation _NMFood (PricesCoreDataGeneratedAccessors)
- (void)addPrices:(NSOrderedSet*)value_ {
	[self.pricesSet unionOrderedSet:value_];
}
- (void)removePrices:(NSOrderedSet*)value_ {
	[self.pricesSet minusOrderedSet:value_];
}
- (void)addPricesObject:(NMPrice*)value_ {
	[self.pricesSet addObject:value_];
}
- (void)removePricesObject:(NMPrice*)value_ {
	[self.pricesSet removeObject:value_];
}
- (void)insertObject:(NMPrice*)value inPricesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"prices"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self prices]];
    [tmpOrderedSet insertObject:value atIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"prices"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"prices"];
}
- (void)removeObjectFromPricesAtIndex:(NSUInteger)idx {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"prices"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self prices]];
    [tmpOrderedSet removeObjectAtIndex:idx];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"prices"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"prices"];
}
- (void)insertPrices:(NSArray *)value atIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"prices"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self prices]];
    [tmpOrderedSet insertObjects:value atIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"prices"];
    [self didChange:NSKeyValueChangeInsertion valuesAtIndexes:indexes forKey:@"prices"];
}
- (void)removePricesAtIndexes:(NSIndexSet *)indexes {
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"prices"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self prices]];
    [tmpOrderedSet removeObjectsAtIndexes:indexes];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"prices"];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexes forKey:@"prices"];
}
- (void)replaceObjectInPricesAtIndex:(NSUInteger)idx withObject:(NMPrice*)value {
    NSIndexSet* indexes = [NSIndexSet indexSetWithIndex:idx];
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"prices"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self prices]];
    [tmpOrderedSet replaceObjectAtIndex:idx withObject:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"prices"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"prices"];
}
- (void)replacePricesAtIndexes:(NSIndexSet *)indexes withPrices:(NSArray *)value {
    [self willChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"prices"];
    NSMutableOrderedSet *tmpOrderedSet = [NSMutableOrderedSet orderedSetWithOrderedSet:[self prices]];
    [tmpOrderedSet replaceObjectsAtIndexes:indexes withObjects:value];
    [self setPrimitiveValue:tmpOrderedSet forKey:@"prices"];
    [self didChange:NSKeyValueChangeReplacement valuesAtIndexes:indexes forKey:@"prices"];
}
@end

