//
//  UNDNetworkRequestURLService.m
//  Undertakes
//
//  Created by Павел Пичкуров on 07.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDNetworkRequestURLService.h"

@implementation UNDNetworkRequestURLService

//+ (NSURL *)getWallRequestURL
//{
//    return [NSURL URLWithString:@""];
//}

+ (NSURL *)getUserPhotoRequestURL:(NSUInteger)userID
{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKToken"];
    NSString *userString = [NSString stringWithFormat:@"%lu",(unsigned long)userID];
    NSString *urlString = [NSString stringWithFormat:@"https://api.vk.com/method/photos.get?owner_id=%@&album_id=profile&rev=1&extended=0&photo_sizes=0&count=1&v=5.71&access_token=%@", userString, token];
    return [NSURL URLWithString: urlString];
}

+ (NSURL *)getFriendListRequestURL
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
    NSString *escapeString = [message stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet alphanumericCharacterSet]];
    NSString *urlString = [NSString stringWithFormat:@"https://api.vk.com/method/wall.post?owner_id=%@&friends_only=1&from_group=0&message=%@&signed=0&mark_as_ads=0&v=5.71&access_token=%@" , userID, escapeString,token];
    NSURL *url = [NSURL URLWithString: urlString];
    return url;
}

+ (NSURL *)getUsersLikeFieldRequestURL:(NSUInteger)fieldID
{
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"VKToken"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.vk.com/method/likes.getList?type=post&owner_id=%@&item_id=%lu&filter=likes&friends_only=0&extended=0&offset=0&count=1000&skip_own=0&v=5.71&access_token=%@", userID, fieldID, token];
    NSLog(@"%@",urlString);
    return [NSURL URLWithString: urlString];
}

@end
