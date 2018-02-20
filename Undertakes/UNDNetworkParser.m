//
//  UNDNetworkParser.m
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDNetworkParser.h"
#import "UNDCoreDataService.h"
#import "UNDStringConstants.h"
#import "NSDictionary+UNDMetaInfo.h"
#import "NSString+UNDStringMetaInfo.h"


@interface UNDNetworkParser ()


@property (nonatomic, strong) UNDCoreDataService *coreDataService;
@property (nonatomic, strong) NSLock *mutex;

@end

@implementation UNDNetworkParser

- (instancetype)init
{
    if (self = [super init])
    {
        _coreDataService = [UNDCoreDataService new];
        _mutex = [NSLock new];
    }
    return self;
}


#pragma mark - Update CoreData & notify controller

- (void)notifyAboutManThatLikedPromise:(NSUInteger)userID receivePhotoURL:(NSString *)urlString
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.outputDelegate photosURLOfMan:userID thatLikedPromiseReceived:urlString];
    });
}

- (void)notifyPhotoLoad
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.outputDelegate photoLoad];
    });
}

- (void)correctLikeMansInAccordanceWith:(NSSet *)likeMans
{
    if (!self.currentPromiseID || !likeMans || likeMans.count == 0)
    {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.outputDelegate listOfMansThatLikedPromise:likeMans];
        [self.coreDataService correctLikeManIDs:likeMans forPromise:self.currentPromiseID];
    });
}

- (void)removeLikeMansFromCoreData
{
    if (self.currentPromiseID)
    {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.coreDataService correctLikeManIDs:nil forPromise:self.currentPromiseID];
    });
}

- (void)savePromiseFieldIDToCoreData:(NSString *)fieldId
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.coreDataService savePromiseFieldIdToCoreData:fieldId.intValue];
    });
}

- (void)savePhoto:(NSString *)fileName forLikeMan:(NSString *)userID
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.coreDataService correctLikeManID:userID photo:fileName];
    });
}


#pragma mark - Parse Response

- (NSDictionary *)parseResponseFromVK:(NSData *)data
{
    if (!data)
    {
        return nil;
    }
    NSDictionary *dataFromVkDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (!dataFromVkDictionary || dataFromVkDictionary.count == 0)
    {
        return nil;
    }
    if ([dataFromVkDictionary und_haveKey:@"error"]
        || ![dataFromVkDictionary und_haveKey:@"response"] )
    {
        return nil;
    }
    NSDictionary *responseVkDictionary = dataFromVkDictionary[@"response"];
    if (!responseVkDictionary
        || ![responseVkDictionary isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    return responseVkDictionary;
}


#pragma mark - Network Output Protocol

- (void)loadUsersThatLikeFieldDidFinishWithData:(NSData *)data
{
    if (!self.currentPromiseID)
    {
        return;
    }
    NSDictionary *responseVkDictionary = [self parseResponseFromVK:data];
    if (!responseVkDictionary
        || ![responseVkDictionary und_haveKey:@"count"]
        || ![responseVkDictionary und_haveKey:@"items"])
    {
        return;
    }
    NSNumber *countNumber = responseVkDictionary[@"count"];
    if (!countNumber || ![countNumber isKindOfClass: [NSNumber class]])
    {
        return;
    }
    if (countNumber.intValue == 0)
    {
        [self removeLikeMansFromCoreData];
        return;
    }
    NSArray *usersArray = responseVkDictionary[@"items"];
    if (!usersArray || ![usersArray isKindOfClass:[NSArray class]])
    {
        return;
    }
    NSSet *users = [NSSet setWithArray:usersArray];
    [self correctLikeMansInAccordanceWith:users];
}

- (void)loadPostPromiseOnUserWallFinishWithData:(NSData *)data
{
    NSDictionary *postIdDict = [self parseResponseFromVK:data];
    if (!postIdDict || ![postIdDict und_haveKey:@"post_id"])
    {
        return;
    }
    NSNumber *fieldId = postIdDict[@"post_id"];
    if (!fieldId)
    {
        return;
    }
    [self savePromiseFieldIDToCoreData:[NSString stringWithFormat:@"%@",fieldId]];
}

- (void)loadUserPhotoURLDidFinishWithData:(NSData *)data
{
    NSDictionary *responseVkDictionary = [self parseResponseFromVK:data];
    if (!responseVkDictionary || ![responseVkDictionary und_haveKey:@"items"])
    {
        return;
    }
    NSArray *itemsArray = responseVkDictionary[@"items"];
    if (!itemsArray
        || ![itemsArray isKindOfClass:[NSArray class]]
        || itemsArray.count == 0)
    {
        return;
    }
    NSDictionary *mainDictionary = [itemsArray firstObject];
    if (!mainDictionary
        || ![mainDictionary isKindOfClass:[NSDictionary class]]
        || ![mainDictionary und_haveKey:@"owner_id"]
        || ![mainDictionary und_haveKey:@"photo_75"])
    {
        return;
    }
    NSNumber *userId = mainDictionary[@"owner_id"];
    if (!userId || ![userId isKindOfClass:[NSNumber class]])
    {
        return;
    }
    NSString *urlString = mainDictionary[@"photo_75"];
    if (!urlString || urlString.length <= 0)
    {
        return;
    }
    [self notifyAboutManThatLikedPromise:userId.intValue receivePhotoURL:urlString];
}

- (void)loadPhotoDidFinishWithData:(NSData *)data taskDescription:(NSString *)description
{
    if (!data
        || !description
        || (description.length <=0)
        || ![description containsString:@"#"])
    {
        return;
    }
    NSArray *descriptionData = [description componentsSeparatedByString:@"#"];
    if (!descriptionData)
    {
        return;
    }
    NSString *userID = [descriptionData lastObject];
    if (!userID
        || (userID.length <= 0)
        || ![userID und_isNumericString])
    {
        return;
    }
    NSString *fileName = [NSString stringWithFormat: [UNDStringConstants getPhotoStringTemplate], userID];
    if (!fileName || [fileName isEqualToString:[UNDStringConstants getPhotoStringTemplate]])
    {
        return;
    }
    NSString *filePath = [[UNDStringConstants getDocumentDirPath] stringByAppendingString:fileName];
    if (!filePath)
    {
        return;
    }
    [self saveData:data toDocumentsFile:filePath];
    [self savePhoto:fileName forLikeMan:userID];
    [self notifyPhotoLoad];
}


#pragma mark - Save to Documents

- (void)saveData:(NSData *)data toDocumentsFile:(NSString *)filePath
{
    [self.mutex lock];
    NSError *error = nil;
    if (![data writeToFile:filePath options:0 error:&error])
    {
        NSLog(@"Error : %@", error);
    }
    error = nil;
    [self.mutex unlock];
}

@end
