//
//  UNDPromiseWeb+CoreDataProperties.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDPromiseWeb+CoreDataProperties.h"

@implementation UNDPromiseWeb (CoreDataProperties)

+ (NSFetchRequest<UNDPromiseWeb *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDPromiseWeb"];
}

@dynamic fieldVkID;
@dynamic likeMans;
@dynamic localVersion;
@dynamic friendOwner;

@end
