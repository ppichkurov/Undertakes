//
//  UNDUserPromisesModel.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDUserPromisesModel.h"
#import "UNDCoreDataService.h"

@interface UNDUserPromisesModel ()

@property (nonatomic, strong) UNDCoreDataService *coreDataService;

@end

@implementation UNDUserPromisesModel

- (instancetype)init
{
    if (self = [super init])
    {
        _coreDataService = [UNDCoreDataService new];
        [self loadPromises];
    }
    return self;
}

- (void)loadPromises
{
    self.promisesArray = [self.coreDataService getPromisesForCurrentUser];
}

@end
