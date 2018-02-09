//
//  UNDUserPromisesModel.h
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UNDPromise+CoreDataClass.h"
#import "UNDUser+CoreDataClass.h"

@interface UNDUserPromisesModel : NSObject

@property (nonatomic, readonly) NSArray<UNDPromise *> *promisesArray;

- (void)update;

- (void)addNewPromiseWithTitle:(NSString *)title
                   description:(NSString *)fullText
                    importance:(NSInteger)importance
                      fireDate:(NSDate *)fireDate;

@end

