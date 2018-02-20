//
//  UNDPromiseDataSourceOutputProtocol.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDPromise+CoreDataClass.h"


@protocol UNDPromiseDataSourceOutputProtocol <NSObject>


@optional
/**
 * <p>Возвращает обещание, полностью находящееся в зоне видимости в коллекшн вью
 * (обещание служит моделью для MaintainerCollectionView</p>
 * @param promise - обещание
 */
- (void)changeCurrentMaintainerCollectionForPromise: (UNDPromise *)promise;

/**
 * <p>Возвращает выбранное тапом обещание для детального просмотра</p>
 * @param promise - обещание
 */
- (void)presentPromise:(UNDPromise *)promise;

/**
 * <p>Оповещает о локальном добавленни нового обещания</p>
 * @param title - заголовок обещания
 * @param fullText - описание обещания
 */
- (void)addPromisCollectionViewWillDismissed:(NSString *)title fulltext:(NSString *)fullText;

@end
