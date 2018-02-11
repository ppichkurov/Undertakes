//
//  UNDPromise+CoreDataProperties.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDPromise+CoreDataProperties.h"

@implementation UNDPromise (CoreDataProperties)

+ (NSFetchRequest<UNDPromise *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDPromise"];
}

@dynamic fireDate;
@dynamic fullText;
@dynamic importance;
@dynamic startDate;
@dynamic title;
@dynamic ownerVkID;
@dynamic webVersion;

@end
