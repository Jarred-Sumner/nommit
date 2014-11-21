// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMUser.m instead.

#import "_NMUser.h"

const struct NMUserAttributes NMUserAttributes = {
	.cardType = @"cardType",
	.creditInCents = @"creditInCents",
	.email = @"email",
	.facebookUID = @"facebookUID",
	.fullName = @"fullName",
	.isCourier = @"isCourier",
	.lastFour = @"lastFour",
	.name = @"name",
	.paymentAuthorized = @"paymentAuthorized",
	.phone = @"phone",
	.referralCode = @"referralCode",
	.stateID = @"stateID",
};

const struct NMUserRelationships NMUserRelationships = {
	.couriers = @"couriers",
	.locations = @"locations",
	.notification = @"notification",
	.orders = @"orders",
	.subscription = @"subscription",
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
	
	if ([key isEqualToString:@"creditInCentsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"creditInCents"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"isCourierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"isCourier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"paymentAuthorizedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"paymentAuthorized"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"stateIDValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stateID"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic cardType;






@dynamic creditInCents;



- (int64_t)creditInCentsValue {
	NSNumber *result = [self creditInCents];
	return [result longLongValue];
}

- (void)setCreditInCentsValue:(int64_t)value_ {
	[self setCreditInCents:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveCreditInCentsValue {
	NSNumber *result = [self primitiveCreditInCents];
	return [result longLongValue];
}

- (void)setPrimitiveCreditInCentsValue:(int64_t)value_ {
	[self setPrimitiveCreditInCents:[NSNumber numberWithLongLong:value_]];
}





@dynamic email;






@dynamic facebookUID;






@dynamic fullName;






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





@dynamic lastFour;






@dynamic name;






@dynamic paymentAuthorized;



- (BOOL)paymentAuthorizedValue {
	NSNumber *result = [self paymentAuthorized];
	return [result boolValue];
}

- (void)setPaymentAuthorizedValue:(BOOL)value_ {
	[self setPaymentAuthorized:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePaymentAuthorizedValue {
	NSNumber *result = [self primitivePaymentAuthorized];
	return [result boolValue];
}

- (void)setPrimitivePaymentAuthorizedValue:(BOOL)value_ {
	[self setPrimitivePaymentAuthorized:[NSNumber numberWithBool:value_]];
}





@dynamic phone;






@dynamic referralCode;






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





@dynamic couriers;

	
- (NSMutableSet*)couriersSet {
	[self willAccessValueForKey:@"couriers"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"couriers"];
  
	[self didAccessValueForKey:@"couriers"];
	return result;
}
	

@dynamic locations;

	

@dynamic notification;

	

@dynamic orders;

	
- (NSMutableSet*)ordersSet {
	[self willAccessValueForKey:@"orders"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"orders"];
  
	[self didAccessValueForKey:@"orders"];
	return result;
}
	

@dynamic subscription;

	






@end
