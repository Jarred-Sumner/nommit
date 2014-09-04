// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMOrder.m instead.

#import "_NMOrder.h"

const struct NMOrderAttributes NMOrderAttributes = {
	.deliveryAddress = @"deliveryAddress",
	.deliveryNote = @"deliveryNote",
	.placedAt = @"placedAt",
	.priceInCents = @"priceInCents",
	.state = @"state",
	.uid = @"uid",
};

const struct NMOrderRelationships NMOrderRelationships = {
	.food = @"food",
	.user = @"user",
};

const struct NMOrderFetchedProperties NMOrderFetchedProperties = {
};

@implementation NMOrderID
@end

@implementation _NMOrder

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMOrder" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMOrder";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMOrder" inManagedObjectContext:moc_];
}

- (NMOrderID*)objectID {
	return (NMOrderID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"priceInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"priceInCents"];
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




@dynamic deliveryAddress;






@dynamic deliveryNote;






@dynamic placedAt;






@dynamic priceInCents;



- (int64_t)priceInCentsValue {
	NSNumber *result = [self priceInCents];
	return [result longLongValue];
}

- (void)setPriceInCentsValue:(int64_t)value_ {
	[self setPriceInCents:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitivePriceInCentsValue {
	NSNumber *result = [self primitivePriceInCents];
	return [result longLongValue];
}

- (void)setPrimitivePriceInCentsValue:(int64_t)value_ {
	[self setPrimitivePriceInCents:[NSNumber numberWithLongLong:value_]];
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





@dynamic food;

	

@dynamic user;

	






@end
