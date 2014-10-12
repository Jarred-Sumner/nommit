// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMPrice.m instead.

#import "_NMPrice.h"

const struct NMPriceAttributes NMPriceAttributes = {
	.price = @"price",
	.quantity = @"quantity",
	.uid = @"uid",
};

const struct NMPriceRelationships NMPriceRelationships = {
	.food = @"food",
};

const struct NMPriceFetchedProperties NMPriceFetchedProperties = {
};

@implementation NMPriceID
@end

@implementation _NMPrice

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMPrice" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMPrice";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMPrice" inManagedObjectContext:moc_];
}

- (NMPriceID*)objectID {
	return (NMPriceID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"quantityValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"quantity"];
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




@dynamic price;






@dynamic quantity;



- (int16_t)quantityValue {
	NSNumber *result = [self quantity];
	return [result shortValue];
}

- (void)setQuantityValue:(int16_t)value_ {
	[self setQuantity:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitiveQuantityValue {
	NSNumber *result = [self primitiveQuantity];
	return [result shortValue];
}

- (void)setPrimitiveQuantityValue:(int16_t)value_ {
	[self setPrimitiveQuantity:[NSNumber numberWithShort:value_]];
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

	






@end
