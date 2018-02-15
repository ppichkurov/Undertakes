//
//  UNDFriend+CoreDataProperties.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDFriend+CoreDataProperties.h"

@implementation UNDFriend (CoreDataProperties)

+ (NSFetchRequest<UNDFriend *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UNDFriend"];
}

@dynamic user;
@dynamic promiseWeb;

@end
