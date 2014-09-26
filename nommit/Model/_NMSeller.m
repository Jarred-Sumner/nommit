// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSeller.m instead.

#import "_NMSeller.h"

const struct NMSellerAttributes NMSellerAttributes = {
	.logoURL = @"logoURL",
	.name = @"name",
	.uid = @"uid",
};

const struct NMSellerRelationships NMSellerRelationships = {
	.couriers = @"couriers",
	.foods = @"foods",
};

const struct NMSellerFetchedProperties NMSellerFetchedProperties = {
};

@implementation NMSellerID
@end

@implementation _NMSeller

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMSeller" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMSeller";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMSeller" inManagedObjectContext:moc_];
}

- (NMSellerID*)objectID {
	return (NMSellerID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"uidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"uid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic logoURL;






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





@dynamic couriers;

	
- (NSMutableSet*)couriersSet {
	[self willAccessValueForKey:@"couriers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"couriers"];
  
	[self didAccessValueForKey:@"couriers"];
	return result;
}
	

@dynamic foods;

	
- (NSMutableSet*)foodsSet {
	[self willAccessValueForKey:@"foods"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"foods"];
  
	[self didAccessValueForKey:@"foods"];
	return result;
}
	






@end
