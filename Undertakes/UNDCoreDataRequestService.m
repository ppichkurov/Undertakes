//
//  UNDCoreDataRequestService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDCoreDataRequestService.h"
#import "UNDStringConstants.h"
#import "NSString+UNDStringMetaInfo.h"


@implementation UNDCoreDataRequestService

+ (NSManagedObjectContext *)coreDataContext
{
    UIApplication *application = [UIApplication sharedApplication];
    NSPersistentContainer *container = ((AppDelegate *)(application.delegate)).persistentContainer;
    NSManagedObjectContext *context = container.viewContext;
    return context;
}

+ (NSFetchRequest *)getRequestByEntityName:(NSString *) entityName
{
    if (!entityName || entityName.length == 0)
    {
        return nil;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: entityName inManagedObjectContext:self.coreDataContext];
    if (!entity)
    {
        return nil;
    }
    [fetchRequest setEntity:entity];
    return fetchRequest;
}

//+ (NSFetchRequest *)currentUserRequest
//{
//    NSString *user = [UNDStringConstants getUserID];
//
//    if (!user)
//    {
//        return nil;
//    }
//
//    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDUser"];
//
//    if (!fetchRequest)
//    {
//        return nil;
//    }
//
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vkID CONTAINS %@", user];
//
//
//    if (!predicate)
//    {
//        return nil;
//    }
//
//    [fetchRequest setPredicate:predicate];
//    return fetchRequest;
//}

+ (NSFetchRequest *)userPromisesRequest:(BOOL)new
{
    NSString *user = [UNDStringConstants getUserID];
    
    if (!user)
    {
        return nil;
    }

    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDPromise"];
    
    if (!fetchRequest)
    {
        return nil;
    }
    
    NSPredicate *predicate;
    if (new)
    {
        predicate = [NSPredicate predicateWithFormat:@"(ownerVkID CONTAINS %@) AND (fireDate > %@)", user, [NSDate date]];
    }
    else
    {
        predicate = [NSPredicate predicateWithFormat:@"(ownerVkID CONTAINS %@) AND (fireDate <= %@)", user, [NSDate date]];
    }
    
    if (!predicate)
    {
        return nil;
    }
    
    [fetchRequest setPredicate:predicate];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate"
                                                                   ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    return fetchRequest;
}

+ (NSFetchRequest *)promiseLikeManRequest:(NSString *)likeManID
{
    if (!likeManID
        || likeManID.length == 0
        || ![likeManID und_isNumericString])
    {
        return nil;
    }
    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDLikeMan"];
    if (!fetchRequest)
    {
        return nil;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vkID CONTAINS %@", likeManID];
    [fetchRequest setPredicate:predicate];
    return fetchRequest;
}

@end
