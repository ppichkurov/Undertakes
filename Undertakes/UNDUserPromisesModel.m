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

@property (nonatomic, strong, readwrite) NSArray<UNDPromise *> *promisesArray;
@property (nonatomic, strong) UNDCoreDataService *coreDataService;

@end

@implementation UNDUserPromisesModel

- (instancetype)init
{
    if (self = [super init])
    {
        _coreDataService = [UNDCoreDataService new];
    }
    return self;
}

- (void)update
{
    [self loadPromises];
}

- (void)loadPromises
{
    self.promisesArray = nil;
    self.promisesArray = [self.coreDataService getPromisesForCurrentUser];
}

- (void)addNewPromiseWithTitle:(NSString *)title
                   description:(NSString *)fullText
                    importance:(NSInteger)importance
                      fireDate:(NSDate *)fireDate
{
    [self.coreDataService savePromiseToCoreDataWithTitle:title
                                             description:fullText
                                              importance:importance
                                                fireDate:fireDate];
    
    //добавить обращение к нетворку с публикацией на стене
}

@end
