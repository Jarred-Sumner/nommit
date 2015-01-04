// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to NMSubscription.m instead.

#import "_NMSubscription.h"

const struct NMSubscriptionAttributes NMSubscriptionAttributes = {
	.email = @"email",
	.pushNotifications = @"pushNotifications",
	.sms = @"sms",
	.uid = @"uid",
};

const struct NMSubscriptionRelationships NMSubscriptionRelationships = {
	.user = @"user",
};

@implementation NMSubscriptionID
@end

@implementation _NMSubscription

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"NMSubscription" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"NMSubscription";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"NMSubscription" inManagedObjectContext:moc_];
}

- (NMSubscriptionID*)objectID {
	return (NMSubscriptionID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"emailValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"email"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"pushNotificationsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pushNotifications"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"smsValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"sms"];
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

@dynamic email;

- (BOOL)emailValue {
	NSNumber *result = [self email];
	return [result boolValue];
}

- (void)setEmailValue:(BOOL)value_ {
	[self setEmail:@(value_)];
}

- (BOOL)primitiveEmailValue {
	NSNumber *result = [self primitiveEmail];
	return [result boolValue];
}

- (void)setPrimitiveEmailValue:(BOOL)value_ {
	[self setPrimitiveEmail:@(value_)];
}

@dynamic pushNotifications;

- (BOOL)pushNotificationsValue {
	NSNumber *result = [self pushNotifications];
	return [result boolValue];
}

- (void)setPushNotificationsValue:(BOOL)value_ {
	[self setPushNotifications:@(value_)];
}

- (BOOL)primitivePushNotificationsValue {
	NSNumber *result = [self primitivePushNotifications];
	return [result boolValue];
}

- (void)setPrimitivePushNotificationsValue:(BOOL)value_ {
	[self setPrimitivePushNotifications:@(value_)];
}

@dynamic sms;

- (BOOL)smsValue {
	NSNumber *result = [self sms];
	return [result boolValue];
}

- (void)setSmsValue:(BOOL)value_ {
	[self setSms:@(value_)];
}

- (BOOL)primitiveSmsValue {
	NSNumber *result = [self primitiveSms];
	return [result boolValue];
}

- (void)setPrimitiveSmsValue:(BOOL)value_ {
	[self setPrimitiveSms:@(value_)];
}

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

@dynamic user;

@end

