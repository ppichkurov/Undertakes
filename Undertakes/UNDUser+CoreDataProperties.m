//
//  UNDUser+CoreDataProperties.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDUser+CoreDataProperties.h"

@implementation UNDUser (CoreDataProperties)

+ (NSFetchRequest<UNDUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDUser"];
}

@dynamic freeTime;
@dynamic token;
@dynamic friends;

@end
