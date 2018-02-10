//
//  UNDCoreDataService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDCoreDataRequestService.h"
#import "UNDUser+CoreDataClass.h"
#import "UNDPromise+CoreDataClass.h"

@interface UNDCoreDataService : NSObject

- (UNDUser *)getCurrentUser;

- (NSArray<UNDPromise *> *)getPromisesForCurrentUser;

- (void)savePromiseToCoreDataWithTitle:(NSString *)title
                           description:(NSString *)fullText
                            importance:(NSInteger)importance
                              fireDate:(NSDate *)fireDate;

- (void)savePromiseFieldIdToCoreData:(int64_t)fieldId;

@end
