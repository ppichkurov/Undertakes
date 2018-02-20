//
//  UNDCoreDataService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDCoreDataService.h"
#import "UNDStringConstants.h"

@interface UNDCoreDataService ()


@property (nonatomic, strong) UNDPromise *lastSavedPromise;

@end

@implementation UNDCoreDataService


- (NSArray<UNDPromise *> *)getPromisesForCurrentUser:(BOOL)new
{
    NSArray *result = [[UNDCoreDataRequestService coreDataContext] executeFetchRequest: [UNDCoreDataRequestService userPromisesRequest:new] error:nil];
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
    if (!title
        || (title.length == 0)
        || !fullText
        || (fullText.length == 0)
        || (importance <= 0)
        || !fireDate)
    {
        return;
    }
    UNDPromise *promise = [NSEntityDescription
                           insertNewObjectForEntityForName:@"UNDPromise"
                                    inManagedObjectContext:[UNDCoreDataRequestService coreDataContext]];
    promise.title = title;
    promise.fullText = fullText;
    promise.importance = importance;
    promise.fireDate = fireDate;
    promise.startDate = [NSDate date];
    promise.ownerVkID = [UNDStringConstants getUserID];

    [promise.managedObjectContext save:nil];
}

- (void)savePromiseFieldIdToCoreData:(int64_t)fieldId
{
    UNDPromiseWeb *promiseWeb = [NSEntityDescription
                           insertNewObjectForEntityForName:@"UNDPromiseWeb"
                           inManagedObjectContext:[UNDCoreDataRequestService coreDataContext]];
    
    if (!promiseWeb)
    {
        return;
    }
    
    promiseWeb.fieldVkID = [NSString stringWithFormat:@"%lld",fieldId];
    
    NSArray<UNDPromise *> *arrayOfPromises = [self getPromisesForCurrentUser:YES];
    UNDPromise *lastAddPromise =  [arrayOfPromises firstObject];
    lastAddPromise.webVersion = promiseWeb;

    [promiseWeb.managedObjectContext save:nil];
}

- (void)correctLikeManIDs:(NSSet<NSNumber *> *)likeMans forPromise:(NSManagedObjectID *)promiseID
{
    if (!promiseID)
    {
        return;
    }
    
    UNDPromise *promiseForSaveLikes = [[UNDCoreDataRequestService coreDataContext]
                                       existingObjectWithID:promiseID error:nil];
    
    if (!promiseForSaveLikes || !promiseForSaveLikes.webVersion)
    {
        return;
    }
        
    if (!likeMans)
    {
        [self removeAllLikeMansForPromise:promiseForSaveLikes];
        return;
    }
    
    //получили тех, кто уже в базе
    NSMutableSet<UNDLikeMan *> *weHaveSaved = [promiseForSaveLikes.webVersion.likeMans mutableCopy];
    
    if (![weHaveSaved count]) // если в базе ничего - просто сохраняем (выделить в метод тупого сохранения)
    {
        [self saveAllLikeMans:likeMans forPromise:promiseForSaveLikes];
        return;
    }
        // добавляем их id в сет
    NSMutableSet *weHaveMansIDMutableSet = [NSMutableSet setWithCapacity: weHaveSaved.count];
    for (UNDLikeMan *entity in weHaveSaved)
    {
        [weHaveMansIDMutableSet addObject: [NSNumber numberWithInt: entity.vkID.intValue]];
    }
        
    NSMutableSet *weNeedToAddMutableSet = [likeMans mutableCopy];
    [weNeedToAddMutableSet minusSet:weHaveMansIDMutableSet];
    
    if (weNeedToAddMutableSet.count)
    {
        [self saveAllLikeMans:[weNeedToAddMutableSet copy] forPromise:promiseForSaveLikes];
    }
    
    NSMutableSet *weNeedToDeleteMutableSet = [NSMutableSet setWithSet:weHaveMansIDMutableSet];
    [weNeedToDeleteMutableSet minusSet: likeMans];
    
    if (weNeedToDeleteMutableSet.count)
    {
        [self removeLikeMans:[weNeedToDeleteMutableSet copy] forPromise:promiseForSaveLikes];
    }
}

- (void)removeAllLikeMansForPromise:(UNDPromise *)promise
{
    for (UNDLikeMan *man in promise.webVersion.likeMans) {
        [[UNDCoreDataRequestService coreDataContext] deleteObject:man];
    }
    [[UNDCoreDataRequestService coreDataContext] save:nil];
    return;
}

- (void)removeLikeMans:(NSSet<NSNumber *> *)likeMans forPromise:(UNDPromise *)promise
{
    for (UNDLikeMan *man in promise.webVersion.likeMans) {
        if ([likeMans containsObject: [NSNumber numberWithInt: man.vkID.intValue]])
        {
            [[UNDCoreDataRequestService coreDataContext] deleteObject:man];
        }
    }
    [[UNDCoreDataRequestService coreDataContext] save:nil];
    
    return;
}

- (void)removePromise:(UNDPromise *)promise
{
    [[UNDCoreDataRequestService coreDataContext] deleteObject:promise];
    [[UNDCoreDataRequestService coreDataContext] save:nil];
    return;
}

- (void)saveAllLikeMans:(NSSet<NSNumber *> *)likeMans forPromise:(UNDPromise *)promise
{
    for (NSNumber *man in likeMans) {
        UNDLikeMan *likeMan = [NSEntityDescription
                               insertNewObjectForEntityForName:@"UNDLikeMan"
                               inManagedObjectContext:[UNDCoreDataRequestService coreDataContext]];
        likeMan.vkID = [NSString stringWithFormat:@"%@",man];
        likeMan.promiseWeb = promise.webVersion;
    }
    [[UNDCoreDataRequestService coreDataContext] save:nil];
}

- (void)correctLikeManID:(NSString *)likeManID photo:(NSString *)photoPath
{
    if (!likeManID
        || likeManID.length == 0
        || !photoPath
        || photoPath.length == 0)
    {
        return;
    }
    
    NSArray<UNDLikeMan *> *ourLikeMans = [[UNDCoreDataRequestService coreDataContext]
                                         executeFetchRequest:[UNDCoreDataRequestService promiseLikeManRequest: likeManID] error:nil];
    
    if (!ourLikeMans)
    {
        return;
    }
    
    for (UNDLikeMan *man in ourLikeMans) {
        man.photo = photoPath;
    }
    [[UNDCoreDataRequestService coreDataContext] save:nil];
}

//- (void)touchAnOldObject
//{
//    NSArray<UNDPromise *> *oldGuysNeedToBeTouched = [self getPromisesForCurrentUser:NO];
//    if (!oldGuysNeedToBeTouched.count)
//    {
//        return;
//    }
//    for (UNDPromise *man in oldGuysNeedToBeTouched) {
//        man.fireDate = man.fireDate;
//    }
//}

@end
