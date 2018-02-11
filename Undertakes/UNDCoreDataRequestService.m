//
//  UNDCoreDataRequestService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDCoreDataRequestService.h"


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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName: entityName inManagedObjectContext:self.coreDataContext];
    [fetchRequest setEntity:entity];
    return fetchRequest;
}

+ (NSFetchRequest *)currentUserRequest
{
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];
    
    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vkID CONTAINS %@", user];
    [fetchRequest setPredicate:predicate];
    return fetchRequest;
}

+ (NSFetchRequest *)userPromisesRequest
{
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];

    NSFetchRequest *fetchRequest = [self getRequestByEntityName:@"UNDPromise"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ownerVkID CONTAINS %@", user];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate"
                                                                   ascending:NO];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    return fetchRequest;
}

@end
