//
//  UNDHuman+CoreDataProperties.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDHuman+CoreDataProperties.h"

@implementation UNDHuman (CoreDataProperties)

+ (NSFetchRequest<UNDHuman *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDHuman"];
}

@dynamic name;
@dynamic photo;
@dynamic vkID;

@end
