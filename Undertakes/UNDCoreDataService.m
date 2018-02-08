//
//  UNDCoreDataService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDCoreDataService.h"

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

@end
