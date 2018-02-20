//
//  NSDictionary+UNDMetaInfo.h
//  Undertakes
//
//  Created by Павел Пичкуров on 16.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (UNDMetaInfo)


/**
 * <p>Проверяет наличие ключа key в словаре</p>
 * @param key - строковый ключ
 * @return YES если в словаре присутствует ключ, иначе NO
 */
- (BOOL)und_haveKey:(NSString *)key;

@end
