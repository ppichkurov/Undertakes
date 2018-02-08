//
//  UNDCoreDataRequestService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface UNDCoreDataRequestService : NSObject

@property (nonatomic, weak) NSManagedObjectContext *coreDataContext;

- (NSFetchRequest *)currentUserRequest;
- (NSFetchRequest *)userPromisesRequest;

@end
