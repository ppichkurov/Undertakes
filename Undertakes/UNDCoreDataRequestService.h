//
//  UNDCoreDataRequestService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "UNDPromise+CoreDataClass.h"


@interface UNDCoreDataRequestService : NSObject

/**
 * <p>Возвращает ManagedObjectContext</p>
 * @return - контекст
 */
+ (NSManagedObjectContext *)coreDataContext;

/**
 * <p>Возвращает fetchedRequest с обещаниями для текущего залогиненного пользователя</p>
 * @param newest - true - обещания, данные в текущий период, false - старые обещания
 * @return реквест
 */
+ (NSFetchRequest *)userPromisesRequest:(BOOL)newest;

/**
 * <p>Возвращает реквест для одного пользователя по id, лайкнувшего обещание </p>
 * @param likeManID - id пользователя в виде строки, лайкнувших обещание
 * @return если likeManID валидный id - возращает реквест, иначе nil
 */
+ (NSFetchRequest *)promiseLikeManRequest:(NSString *)likeManID;

@end
