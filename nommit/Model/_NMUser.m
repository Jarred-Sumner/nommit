// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMUser.m instead.

#import "_NMUser.h"

const struct NMUserAttributes NMUserAttributes = {
	.email = @"email",
	.facebookUID = @"facebookUID",
	.name = @"name",
	.phone = @"phone",
};

const struct NMUserRelationships NMUserRelationships = {
	.addresses = @"addresses",
	.orders = @"orders",
};

const struct NMUserFetchedProperties NMUserFetchedProperties = {
};

@implementation NMUserID
@end

@implementation _NMUser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMUser" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMUser";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMUser" inManagedObjectContext:moc_];
}

- (NMUserID*)objectID {
	return (NMUserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic email;






@dynamic facebookUID;






@dynamic name;






@dynamic phone;






@dynamic addresses;

	

@dynamic orders;

	
- (NSMutableSet*)ordersSet {
	[self willAccessValueForKey:@"orders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"orders"];
  
	[self didAccessValueForKey:@"orders"];
	return result;
}
	






@end
