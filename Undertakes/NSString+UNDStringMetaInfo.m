//
//  NSString+UNDStringMetaInfo.m
//  Undertakes
//
//  Created by Павел Пичкуров on 16.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "NSString+UNDStringMetaInfo.h"


@implementation NSString (UNDStringMetaInfo)

- (BOOL)und_isNumericString
{
    return [self rangeOfCharacterFromSet:
            [[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound;
}

@end
