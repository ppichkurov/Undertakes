//
//  UNDStringConstants.h
//  Undertakes
//
//  Created by Павел Пичкуров on 13.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UNDStringConstants : NSObject

/**
 * <p>Возвращает путь до папки Documents</p>
 * @return путь до папки в виде строки
 */
+ (NSString *)getDocumentDirPath;

/**
 * <p>Возвращает шаблон названия файла фото</p>
 * @return шаблон типа @"/%@.jpg"
 */
+ (NSString *)getPhotoStringTemplate;

/**
 * <p>Возвращает  id VK пользователя</p>
 * @return id VK в виде строки
 */
+ (NSString *)getUserID;

/**
 * <p>Возвращает токен VK пользователя</p>
 * @return токен VK в виде строки
 */
+ (NSString *)getToken;

@end
