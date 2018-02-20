//
//  UNDParserOutputProtocol.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UNDParserOutputProtocol <NSObject>
@optional

/**
 * <p>Возвращает множество, содержащее
 * ID пользователей, лайкнувших обещание на стене VK</p>
 * @param likeMans - множество ID типа NSNumber
 */
- (void)listOfMansThatLikedPromise:(NSSet<NSNumber *> *)likeMans;

/**
 * <p>Возвращает URL фото пользователя, лайкнувшего обещание на стене VK</p>
 * @param userID - ID пользователя, лайкнувшего запись
 * @param urlString - строковое представление URL для загрузки фото пользователя
 */
- (void)photosURLOfMan:(NSUInteger)userID thatLikedPromiseReceived:(NSString *)urlString;

/**
 * <p>Оповещение о том, что фото было сохранено на диск</p>
 */
- (void)photoLoad;

@end
