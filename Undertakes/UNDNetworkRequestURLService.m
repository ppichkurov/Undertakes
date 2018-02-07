//
//  UNDNetworkRequestURLService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDNetworkRequestURLService.h"

@implementation UNDNetworkRequestURLService

+ (NSURL *)getWallRequestURL
{
    return [NSURL URLWithString:@""];
}

+ (NSURL *)getUserPhotoRequestURL
{
    return [NSURL URLWithString:@""];
}

+ (NSURL *)getFriendListRequestURL
{
    return [NSURL URLWithString:@""];
}

+ (NSURL *)getUsersLikeFieldRequestURL
{
    return [NSURL URLWithString:@""];
}

+ (NSURL *)getLikeFriendPromiseRequestURL
{
    return [NSURL URLWithString:@""];
}

+ (NSURL *)getAuthVKRequestURL {
    return [NSURL URLWithString:@"https://oauth.vk.com/authorize?client_id=6362455&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&scope=73734&response_type=token&v=5.71&state=123456"];
}

+ (NSURL *)getLogoutVkRequestURL
{
    return [NSURL URLWithString: @"https://login.vk.com/?act=logout"];
}

@end
