//
//  UNDUser+CoreDataProperties.m
//  
//
//  Created by Павел Пичкуров on 08.02.2018.
//
//

#import "UNDUser+CoreDataProperties.h"

@implementation UNDUser (CoreDataProperties)

+ (NSFetchRequest<UNDUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDUser"];
}

@dynamic freeTime;
@dynamic name;
@dynamic photo;
@dynamic vkID;

@end
