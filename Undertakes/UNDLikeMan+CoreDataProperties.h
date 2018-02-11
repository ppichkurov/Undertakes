//
//  UNDLikeMan+CoreDataProperties.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDLikeMan+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDLikeMan (CoreDataProperties)

+ (NSFetchRequest<UNDLikeMan *> *)fetchRequest;

@property (nullable, nonatomic, retain) UNDPromiseWeb *promiseWeb;

@end

NS_ASSUME_NONNULL_END
