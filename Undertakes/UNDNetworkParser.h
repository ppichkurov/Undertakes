//
//  UNDNetworkParser.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDParserOutputProtocol.h"
#import "UNDNetworkServiceIOProtocol.h"


@interface UNDNetworkParser : NSObject <UNDNetworkServiceOutputProtocol>


/**
 * <p>Делегат, получает данные и уведомления о распарсенных данных</p>
 */
@property (nonatomic, weak) id<UNDParserOutputProtocol> outputDelegate;

/**
 * <p>Делегат обрабатывающий данные из сети</p>
 */
@property (nonatomic, weak) NSManagedObjectID *currentPromiseID;

@end
