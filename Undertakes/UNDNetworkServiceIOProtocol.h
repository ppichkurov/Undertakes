//
//  UNDNetworkServiceInputProtocol.h
//  Undertakes
//
//  Created by Павел Пичкуров on 06.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "UNDPromise+CoreDataClass.h"


@protocol UNDNetworkServiceInputProtocol <NSObject>


@optional
/**
 * <p>Получение URL фото по id пользователя</p>
 * @param userID - id пользователя
 */
- (void)getUserPhotoURL:(NSUInteger) userID;

/**
 * <p>Получение фото юзера по URL</p>
 * @param urlString - строка с url фото
 * @param userID - id юзера
 */
- (void)getPhotoByURL:(NSString *)urlString userID:(NSUInteger)userID;

/**
 * <p>Получение списка людей, лайкнувших запись на стене fieldID </p>
 * @param fieldID - id записи на стене
 */
- (void)getUsersThatLikeField:(NSUInteger)fieldID;

/**
 * <p>Создать запись на стене нашего пользователя с данными из обещания</p>
 * @param title - заголовок обещания (Я хочу)
 * @param fullText - описание обещания (Потому что)
 */
- (void)createPromiseOnTheUserWallWithTitle:(NSString *)title
                                   fulltext:(NSString *)fullText;

@end


@protocol UNDNetworkServiceOutputProtocol <NSObject>


@optional

/**
 * <p>Результат запроса на список лайкнувших</p>
 * @param data - респонс
 */
- (void)loadUsersThatLikeFieldDidFinishWithData:(NSData *)data;

/**
 * <p>Результат запроса на список URL фото лайкнувших</p>
 * @param data - респонс
 */
- (void)loadUserPhotoURLDidFinishWithData:(NSData *)data;

/**
 * <p>Результат запроса с фото лайкнувшего</p>
 * @param data - респонс
 */
- (void)loadPhotoDidFinishWithData:(NSData *)data taskDescription:(NSString *)description;

/**
 * <p>результат запроса публикацию обещания</p>
 * @param data - респонс
 */
- (void)loadPostPromiseOnUserWallFinishWithData:(NSData *)data;

@end
