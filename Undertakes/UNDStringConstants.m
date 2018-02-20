//
//  UNDStringConstants.m
//  Undertakes
//
//  Created by Павел Пичкуров on 13.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDStringConstants.h"


@implementation UNDStringConstants

+ (NSString *)getDocumentDirPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)getPhotoStringTemplate
{
    return @"/%@.jpg";
}

+ (NSString *)getUserID
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"VKUser"];
}

+ (NSString *)getToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"VKToken"];
}

@end
