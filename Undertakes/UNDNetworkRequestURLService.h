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


/**
 * <p>Возвращает URL запрос к api vk для аутентификации</p>
 * @return URL для аутентификации
 */
+ (NSURL *)getAuthVKRequestURL;

/**
 * <p>Возвращает URL запрос к api vk для полученик списка пользователей
 * лайкнувших запись</p>
 * @param fieldID - id обещания на стене VK
 * @return URL для api vk
 */
+ (NSURL *)getUsersLikeFieldRequestURL:(NSUInteger)fieldID;

/**
 * <p>Возвращает URL запрос к api vk для полученик списка URL фото пользователей
 * лайкнувших запись</p>
 * @param userID - id пользователя, лайкнувшего обещание на стене VK
 * @return URL для api vk
 */
+ (NSURL *)getUserPhotoRequestURL:(NSUInteger)userID;

/**
 * <p>Возвращает URL запрос к api vk для публикации обещания на стене</p>
 * @param title - заголовок обещания
 * @param fullText - описание обещания
 * @return URL для api vk
 */
+ (NSURL *)getCreatePromiseOnTheUserWallRequestURL:(NSString *)title fulltext:(NSString *)fullText;

@end
