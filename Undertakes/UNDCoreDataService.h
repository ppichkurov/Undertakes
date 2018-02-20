//
//  UNDCoreDataService.h
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDCoreDataRequestService.h"
#import "UNDUser+CoreDataClass.h"
#import "UNDPromise+CoreDataClass.h"
#import "UNDPromiseWeb+CoreDataClass.h"
#import "UNDHuman+CoreDataClass.h"
#import "UNDLikeMan+CoreDataClass.h"


@interface UNDCoreDataService : NSObject


/**
 * <p>Возвращает массив обещаний для текущего пользователя</p>
 * param newest - true - вернутся непросроченные обещания (fireDate не наступила), false - просроченные
 */
- (NSArray<UNDPromise *> *)getPromisesForCurrentUser:(BOOL)newest;

/**
 * <p>Сохраняет обещание в кордату</p>
 * @param title - заголовок обещания ( Я хочу : )
 * @param fullText - описание обещания ( Потому что : )
 * @param importance - важность ( от 1 до 5 )
 * @param fireDate - дата окончания ( хочу делать до / успеть до )
 */
- (void)savePromiseToCoreDataWithTitle:(NSString *)title
                           description:(NSString *)fullText
                            importance:(NSInteger)importance
                              fireDate:(NSDate *)fireDate;

/**
 * <p>Сохраняет id записи VK для последнего добавленного обещания</p>
 * @param fieldId - id записи на стене VK
 */
- (void)savePromiseFieldIdToCoreData:(int64_t)fieldId;

/**
 * <p>Корректирует список пользователей, лайкнувших обещание в VK</p>
 * @param likeMans - id пользователей, лайкнувших обещание
 * @param promiseID - id обещания, по которому можно достать из кордаты объект
 */
- (void)correctLikeManIDs:(NSSet<NSNumber *> *)likeMans forPromise:(NSManagedObjectID *)promiseID;

/**
 * <p>Сохраняет путь к фото пользователя, лайкнувшего обещание</p>
 * @param likeManID - id пользователя, лайкнувшего обещание
 * @param photoPath - относительный путь от папки документов у фото ( @"/id.jpg" )
 */
- (void)correctLikeManID:(NSString *)likeManID photo:(NSString *)photoPath;

/**
 * <p>Удаляет локальное обещание</p>
 * @param promise - обещание
 */
- (void)removePromise:(UNDPromise *)promise;

@end
