//
//  UNDNetworkRequestURLService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDPromise+CoreDataClass.h"


@interface UNDNetworkRequestURLService : NSObject

// реализовано

+ (NSURL *)getAuthVKRequestURL;
+ (NSURL *)getUsersLikeFieldRequestURL:(NSUInteger)fieldID;
+ (NSURL *)getUserPhotoRequestURL:(NSUInteger)userID;
+ (NSURL *)getCreatePromiseOnTheUserWallRequestURL:(NSString *)title fulltext:(NSString *)fullText;

// не реализовано

//+ (NSURL *)getLikeFriendPromiseRequestURL;
//+ (NSURL *)getFriendListRequestURL;
//+ (NSURL *)getWallRequestURL;


@end
