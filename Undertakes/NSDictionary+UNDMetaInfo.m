//
//  NSDictionary+UNDMetaInfo.m
//  Undertakes
//
//  Created by Павел Пичкуров on 16.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "NSDictionary+UNDMetaInfo.h"


@implementation NSDictionary (UNDMetaInfo)

- (BOOL)und_haveKey:(NSString *)key
{
    return [[self allKeys] containsObject:key];
}

@end
