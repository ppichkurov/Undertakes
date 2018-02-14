//
//  UNDPromise+CoreDataProperties.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDPromise+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDPromise (CoreDataProperties)

+ (NSFetchRequest<UNDPromise *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *fireDate;
@property (nullable, nonatomic, copy) NSString *fullText;
@property (nonatomic) int64_t importance;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) NSString *ownerVkID;
@property (nullable, nonatomic, retain) UNDPromiseWeb *webVersion;

@end

NS_ASSUME_NONNULL_END
