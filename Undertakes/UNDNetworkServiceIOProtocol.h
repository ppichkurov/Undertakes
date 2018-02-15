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
 * <p>Получение стены пользователя</p>
 * @param userID - id пользователя
 */
//- (BOOL)getWallByUserID:(NSUInteger) userID;

/**
 * <p>Получение друзей текущего пользователя</p>
 */
//- (void)getFriendList;

/**
 * <p>Получение URL фото по id пользователя</p>
 * @param userID - id пользователя
 */
- (void)getUserPhotoURL:(NSUInteger) userID; // реализовано

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
- (void)getUsersThatLikeField:(NSUInteger)fieldID; // реализовано ( возможно переделать в закачку всех лайкнувших)

/**
 * <p>Лайкнуть запись на стене fieldID </p>
 * @param fieldID - id записи на стене
 */
//- (void)likeFriendsPromise:(NSUInteger)fieldID;

/**
 * <p>Создать запись на стене нашего пользователя с данными из обещания</p>
 * @param title - заголовок обещания (Я хочу)
 * @param fullText - описание обещания (Потому что)
 */
- (void)createPromiseOnTheUserWallWithTitle:(NSString *)title
                                   fulltext:(NSString *)fullText; //реализовано

@end


@protocol UNDNetworkServiceOutputProtocol <NSObject>
@optional

//- (void)nowLoadingWithProgress: (double) progress;

//- (void)loadLikeFriendPromiseDidFinishWithData:(NSData *)data;

- (void)loadUsersThatLikeFieldDidFinishWithData:(NSData *)data; //реализован

//- (void)loadFriendListDidFinishWithData:(NSData *)data;

- (void)loadUserPhotoURLDidFinishWithData:(NSData *)data; //реализован

- (void)loadPhotoDidFinishWithData:(NSData *)data taskDescription:(NSString *)description; //реализован

//- (void)loadWallDidFinishWithData:(NSData *)data;

- (void)loadPostPromiseOnUserWallFinishWithData:(NSData *)data; //реализован

@end
