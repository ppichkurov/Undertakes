//
//  UNDCoreDataService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDCoreDataService.h"

//TODO сделать из этого класса фасад (кор дата + сеть)

@interface UNDCoreDataService ()

@property (nonatomic, strong) UNDCoreDataRequestService *requestService;

@end

@implementation UNDCoreDataService


- (instancetype)init
{
    if (self = [super init])
    {
        _requestService = [UNDCoreDataRequestService new];
    }
    return self;
}

- (NSArray<UNDPromise *> *)getPromisesForCurrentUser
{
    NSArray *result = [self.requestService.coreDataContext executeFetchRequest: [self.requestService userPromisesRequest] error:nil];
    return result;
}

- (UNDUser *)getCurrentUser
{
    NSArray *result = [self.requestService.coreDataContext executeFetchRequest: [self.requestService userPromisesRequest] error:nil];
    UNDUser *user = result[0];
    return user;
}

- (void)savePromiseToCoreDataWithTitle:(NSString *)title
                           description:(NSString *)fullText
                            importance:(NSInteger)importance
                              fireDate:(NSDate *)fireDate
{
    UNDPromise *promise = [NSEntityDescription insertNewObjectForEntityForName:@"UNDPromise" inManagedObjectContext: self.requestService.coreDataContext];
    
    promise.title = title;
    promise.fullText = fullText;
    promise.importance = importance;
    promise.fireDate = fireDate;
    promise.startDate = [NSDate date];
    promise.userVkID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"] intValue];
    
    NSError *error = nil;
    
    if (![promise.managedObjectContext save:&error])
    {
        NSLog(@"bad save try, error : %@", error);
    }
    
    error = nil;
}

@end
