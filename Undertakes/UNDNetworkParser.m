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

//static NSString *UNDDocumentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];


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

- (void)loadUsersThatLikeFieldDidFinishWithData:(NSData *)data
{
//    {
//        "response": {
//            "count": 2,
//            "items": [25839411]
//        }
//    }
    
//если нет такой записи
//    {
//        "response": {
//            "count": 0,
//            "items": []
//        }
//    }
    
    if (!self.currentPromiseID)
    {
        return;
    }
    
    NSDictionary *dataFromVkDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (!dataFromVkDictionary)
    {
        return;
    }
    
    if ([[dataFromVkDictionary allKeys] containsObject:@"error"])
    {
        return;
    }
    
    NSDictionary *responseVkDictionary = dataFromVkDictionary[@"response"];
    NSNumber *count = responseVkDictionary[@"count"];
    if (count.intValue == 0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.coreDataService correctLikeManIDs:nil forPromise:self.currentPromiseID];
        });
        return;
    }
    else
    {
        NSArray *usersArray = responseVkDictionary[@"items"];
        NSSet *users = [NSSet setWithArray:usersArray];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.outputDelegate listOfMansThatLikedPromise:users];
            [self.coreDataService correctLikeManIDs:users forPromise:self.currentPromiseID];
        });
    }
}

- (void)loadPostPromiseOnUserWallFinishWithData:(NSData *)data
{
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *postIdDict = dataDictionary[@"response"];
    NSString *fieldId = postIdDict[@"post_id"];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.coreDataService savePromiseFieldIdToCoreData: fieldId.intValue];
    });
}

- (void)loadUserPhotoURLDidFinishWithData:(NSData *)data
{
    NSDictionary *dataFromVkDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if (!dataFromVkDictionary)
    {
        return;
    }
    
    if ([[dataFromVkDictionary allKeys] containsObject:@"error"])
    {
        return;
    }
    NSDictionary *responseVkDictionary = dataFromVkDictionary[@"response"];
    NSArray *itemsDictionary = responseVkDictionary[@"items"];
    NSDictionary *izdevatelstvo = [itemsDictionary firstObject];
    NSNumber *userId = izdevatelstvo[@"owner_id"];
    if (![[izdevatelstvo allKeys] containsObject:@"photo_75"])
    {
        return;
    }
    NSString *urlString = izdevatelstvo[@"photo_75"];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.outputDelegate photosURLOfMan: userId.intValue thatLikedPromiseReceived: urlString];
    });
}

- (void)loadPhotoDidFinishWithData:(NSData *)data taskDescription:(NSString *)description
{
    NSLog(@"фото прилетело: %@", description);
    NSArray *descriptioData = [description componentsSeparatedByString:@"#"];
    NSString *userID = descriptioData[1];
    NSString *fileName = [NSString stringWithFormat: [UNDStringConstants getPhotoStringTemplate], userID];
    NSString *filePath = [[UNDStringConstants getDocumentDirPath] stringByAppendingString:fileName];
    
    [self.mutex lock];
    NSError *error = nil;
    if (![data writeToFile:filePath options:0 error:&error])
    {
        NSLog(@"Error : %@", error);
    }
    error = nil;
    [self.mutex unlock];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.coreDataService correctLikeManID:userID Photo:filePath];
    });
}


@end
