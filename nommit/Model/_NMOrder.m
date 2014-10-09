// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMOrder.m instead.

#import "_NMOrder.h"

const struct NMOrderAttributes NMOrderAttributes = {
	.chargeStateID = @"chargeStateID",
	.deliveredAt = @"deliveredAt",
	.discountInCents = @"discountInCents",
	.placedAt = @"placedAt",
	.priceChargedInCents = @"priceChargedInCents",
	.priceInCents = @"priceInCents",
	.promoCode = @"promoCode",
	.quantity = @"quantity",
	.rating = @"rating",
	.stateID = @"stateID",
	.tipInCents = @"tipInCents",
	.uid = @"uid",
};

const struct NMOrderRelationships NMOrderRelationships = {
	.courier = @"courier",
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
	if ([key isEqualToString:@"priceChargedInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"priceChargedInCents"];
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
	if ([key isEqualToString:@"tipInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"tipInCents"];
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






@dynamic priceChargedInCents;



- (int64_t)priceChargedInCentsValue {
	NSNumber *result = [self priceChargedInCents];
	return [result longLongValue];
}

- (void)setPriceChargedInCentsValue:(int64_t)value_ {
	[self setPriceChargedInCents:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitivePriceChargedInCentsValue {
	NSNumber *result = [self primitivePriceChargedInCents];
	return [result longLongValue];
}

- (void)setPrimitivePriceChargedInCentsValue:(int64_t)value_ {
	[self setPrimitivePriceChargedInCents:[NSNumber numberWithLongLong:value_]];
}





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





@dynamic tipInCents;



- (int64_t)tipInCentsValue {
	NSNumber *result = [self tipInCents];
	return [result longLongValue];
}

- (void)setTipInCentsValue:(int64_t)value_ {
	[self setTipInCents:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveTipInCentsValue {
	NSNumber *result = [self primitiveTipInCents];
	return [result longLongValue];
}

- (void)setPrimitiveTipInCentsValue:(int64_t)value_ {
	[self setPrimitiveTipInCents:[NSNumber numberWithLongLong:value_]];
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

	

@dynamic food;

	

@dynamic place;

	

@dynamic user;

	






@end
