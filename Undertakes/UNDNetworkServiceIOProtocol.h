//
//  UNDNetworkIOProtocol.h
//  Undertakes
//
//  Created by Павел Пичкуров on 06.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol UNDNetworkServiceInputProtocol <NSObject>
@optional

// в этих методах нужно создать и стартовать таски

/**
 * <p>Получение токена ВКонтакте для использования API</p>
 */
- (void)getVkAccessToken;

/**
 * <p>Получение стены пользователя</p>
 * @param userID - id пользователя
 */
- (BOOL)getWallByUserID:(NSUInteger) userID;

/**
 * <p>Получение друзей текущего пользователя</p>
 */
- (void)getFriendList;

- (void)getUserPhoto:(NSUInteger) userID;
//https://vk.com/dev/photos.get?params[owner_id]=7627791&params[album_id]=profile&params[rev]=1&params[extended]=0&params[photo_sizes]=0&params[count]=1&params[v]=5.71

- (void)getUsersThatLikeField:(NSUInteger) fieldID;

- (void)likeFriendsPromise:(NSUInteger) fieldID;

@end


@protocol UNDNetworkServiceOutputProtocol <NSObject>
@optional

//- (void)nowLoadingWithProgress: (double) progress;

- (void)loadLikeFriendPromiseDidFinishWithData: (NSData *)data;

- (void)loadLikeFieldUsersDidFinishWithData: (NSData *)data;

- (void)loadFriendListDidFinishWithData: (NSData *)data;

- (void)loadUserPhotoDidFinishWithData: (NSData *)data;

- (void)loadWallDidFinishWithData: (NSData *)data;






@end
