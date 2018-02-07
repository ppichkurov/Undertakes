//
//  UNDNetworkRequestURLService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UNDNetworkRequestURLService : NSObject

+ (NSURL *)getAuthVKRequestURL;
+ (NSURL *)getLikeFriendPromiseRequestURL;
+ (NSURL *)getUsersLikeFieldRequestURL;
+ (NSURL *)getFriendListRequestURL;
+ (NSURL *)getUserPhotoRequestURL;
+ (NSURL *)getWallRequestURL;
+ (NSURL *)getLogoutVkRequestURL;

@end
