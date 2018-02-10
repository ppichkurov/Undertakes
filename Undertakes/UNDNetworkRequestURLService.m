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

+ (NSURL *)getCreatePromiseOnTheUserWallRequestURL:(NSString *)title fulltext:(NSString *)fullText
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKToken"];
    NSString *message = [NSString stringWithFormat:@"Я хочу: %@ Потому что: %@ #Undertakes", title, fullText];
    NSString *escStr = [message stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet alphanumericCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?owner_id=%@&friends_only=1&from_group=0&message=%@&signed=0&mark_as_ads=0&v=5.71&access_token=%@" , userID, escStr,token];
    NSURL *url = [NSURL URLWithString: urlString];
    return url;
//    https://vk.com/wall.search?params[owner_id]=6&params[query]=vk&params[owners_only]=0&params[count]=2&params[offset]=0&params[extended]=0&params[v]=5.71
    
//    https://vk.com/wall.post?params[owner_id]=%@&params[friends_only]=1&params[from_group]=0&params[message]=New%20post%20on%20group%20wall%20via%20API.console.&params[signed]=0&params[mark_as_ads]=0&params[v]=5.71
}

@end
