//
//  UNDCoreDataService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDCoreDataService.h"

@interface UNDCoreDataService ()


@property (nonatomic, strong) UNDPromise *lastSavedPromise;

@end

@implementation UNDCoreDataService


- (NSArray<UNDPromise *> *)getPromisesForCurrentUser
{
    NSArray *result = [[UNDCoreDataRequestService coreDataContext] executeFetchRequest: [UNDCoreDataRequestService userPromisesRequest] error:nil];
    return result;
}

//- (UNDUser *)getCurrentUser
//{
//    NSArray *result = [self.requestService.coreDataContext executeFetchRequest: [self.requestService userPromisesRequest] error:nil];
//    UNDUser *user = result[0];
//    return user;
//}

- (void)savePromiseToCoreDataWithTitle:(NSString *)title
                           description:(NSString *)fullText
                            importance:(NSInteger)importance
                              fireDate:(NSDate *)fireDate
{
    UNDPromise *promise = [NSEntityDescription
                           insertNewObjectForEntityForName:@"UNDPromise"
                                    inManagedObjectContext:[UNDCoreDataRequestService coreDataContext]];
    
//    self.lastSavedPromise = promise;
    
    promise.title = title;
    promise.fullText = fullText;
    promise.importance = importance;
    promise.fireDate = fireDate;
    promise.startDate = [NSDate date];
    promise.userVkID = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];
    
    NSError *error = nil;
    
    if (![promise.managedObjectContext save:&error])
    {
        NSLog(@"bad save try, error : %@", error);
    }
    
    error = nil;
}

- (void)savePromiseFieldIdToCoreData:(int64_t)fieldId
{
//    self.lastSavedPromise.fieldVkID = fieldId;
    
//    NSError *error = nil;
//
//    if (![self.lastSavedPromise.managedObjectContext save:&error])
//    {
//        NSLog(@"bad save try, error : %@", error);
//    }
//
//    error = nil;
}

@end
