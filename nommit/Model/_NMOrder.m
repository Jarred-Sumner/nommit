// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMOrder.m instead.

#import "_NMOrder.h"

const struct NMOrderAttributes NMOrderAttributes = {
	.chargeStateID = @"chargeStateID",
	.deliveredAt = @"deliveredAt",
	.discountInCents = @"discountInCents",
	.placedAt = @"placedAt",
	.priceInCents = @"priceInCents",
	.promoCode = @"promoCode",
	.quantity = @"quantity",
	.rating = @"rating",
	.stateID = @"stateID",
	.uid = @"uid",
};

const struct NMOrderRelationships NMOrderRelationships = {
	.food = @"food",
	.place = @"place",
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
	
	if ([key isEqualToString:@"chargeStateIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"chargeStateID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"discountInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"discountInCents"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"priceInCents"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"quantityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"quantity"];
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




@dynamic chargeStateID;



- (int16_t)chargeStateIDValue {
	NSNumber *result = [self chargeStateID];
	return [result shortValue];
}

- (void)setChargeStateIDValue:(int16_t)value_ {
	[self setChargeStateID:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveChargeStateIDValue {
	NSNumber *result = [self primitiveChargeStateID];
	return [result shortValue];
}

- (void)setPrimitiveChargeStateIDValue:(int16_t)value_ {
	[self setPrimitiveChargeStateID:[NSNumber numberWithShort:value_]];
}





@dynamic deliveredAt;






@dynamic discountInCents;



- (int64_t)discountInCentsValue {
	NSNumber *result = [self discountInCents];
	return [result longLongValue];
}

- (void)setDiscountInCentsValue:(int64_t)value_ {
	[self setDiscountInCents:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveDiscountInCentsValue {
	NSNumber *result = [self primitiveDiscountInCents];
	return [result longLongValue];
}

- (void)setPrimitiveDiscountInCentsValue:(int64_t)value_ {
	[self setPrimitiveDiscountInCents:[NSNumber numberWithLongLong:value_]];
}





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





@dynamic promoCode;






@dynamic quantity;



- (int32_t)quantityValue {
	NSNumber *result = [self quantity];
	return [result intValue];
}

- (void)setQuantityValue:(int32_t)value_ {
	[self setQuantity:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveQuantityValue {
	NSNumber *result = [self primitiveQuantity];
	return [result intValue];
}

- (void)setPrimitiveQuantityValue:(int32_t)value_ {
	[self setPrimitiveQuantity:[NSNumber numberWithInt:value_]];
}





@dynamic rating;



- (int16_t)ratingValue {
	NSNumber *result = [self rating];
	return [result shortValue];
}

- (void)setRatingValue:(int16_t)value_ {
	[self setRating:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveRatingValue {
	NSNumber *result = [self primitiveRating];
	return [result shortValue];
}

- (void)setPrimitiveRatingValue:(int16_t)value_ {
	[self setPrimitiveRating:[NSNumber numberWithShort:value_]];
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





@dynamic food;

	

@dynamic place;

	

@dynamic user;

	






@end
