// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMUser.m instead.

#import "_NMUser.h"

const struct NMUserAttributes NMUserAttributes = {
	.email = @"email",
	.facebookUID = @"facebookUID",
	.isCourier = @"isCourier",
	.name = @"name",
	.phone = @"phone",
	.referralCode = @"referralCode",
	.referralCredit = @"referralCredit",
};

const struct NMUserRelationships NMUserRelationships = {
	.couriers = @"couriers",
	.locations = @"locations",
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
	
	if ([key isEqualToString:@"isCourierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isCourier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"referralCreditValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"referralCredit"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic email;






@dynamic facebookUID;






@dynamic isCourier;



- (BOOL)isCourierValue {
	NSNumber *result = [self isCourier];
	return [result boolValue];
}

- (void)setIsCourierValue:(BOOL)value_ {
	[self setIsCourier:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveIsCourierValue {
	NSNumber *result = [self primitiveIsCourier];
	return [result boolValue];
}

- (void)setPrimitiveIsCourierValue:(BOOL)value_ {
	[self setPrimitiveIsCourier:[NSNumber numberWithBool:value_]];
}





@dynamic name;






@dynamic phone;






@dynamic referralCode;






@dynamic referralCredit;



- (double)referralCreditValue {
	NSNumber *result = [self referralCredit];
	return [result doubleValue];
}

- (void)setReferralCreditValue:(double)value_ {
	[self setReferralCredit:[NSNumber numberWithDouble:value_]];
}

- (double)primitiveReferralCreditValue {
	NSNumber *result = [self primitiveReferralCredit];
	return [result doubleValue];
}

- (void)setPrimitiveReferralCreditValue:(double)value_ {
	[self setPrimitiveReferralCredit:[NSNumber numberWithDouble:value_]];
}





@dynamic couriers;

	
- (NSMutableSet*)couriersSet {
	[self willAccessValueForKey:@"couriers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"couriers"];
  
	[self didAccessValueForKey:@"couriers"];
	return result;
}
	

@dynamic locations;

	

@dynamic orders;

	
- (NSMutableSet*)ordersSet {
	[self willAccessValueForKey:@"orders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"orders"];
  
	[self didAccessValueForKey:@"orders"];
	return result;
}
	






@end
