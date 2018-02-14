//
//  UNDLikeMan+CoreDataProperties.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDLikeMan+CoreDataProperties.h"

@implementation UNDLikeMan (CoreDataProperties)

+ (NSFetchRequest<UNDLikeMan *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDLikeMan"];
}

@dynamic promiseWeb;

@end
