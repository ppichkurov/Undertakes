//
//  UNDPromise+CoreDataProperties.m
//  
//
//  Created by Павел Пичкуров on 08.02.2018.
//
//

#import "UNDPromise+CoreDataProperties.h"

@implementation UNDPromise (CoreDataProperties)

+ (NSFetchRequest<UNDPromise *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDPromise"];
}

@dynamic fieldVkID;
@dynamic fireDate;
@dynamic fullText;
@dynamic hashTag;
@dynamic importance;
@dynamic likeCount;
@dynamic perDayTime;
@dynamic startDate;
@dynamic title;
@dynamic userVkID;

@end
