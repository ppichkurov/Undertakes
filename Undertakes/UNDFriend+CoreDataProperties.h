//
//  UNDFriend+CoreDataProperties.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDFriend+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDFriend (CoreDataProperties)

+ (NSFetchRequest<UNDFriend *> *)fetchRequest;

@property (nullable, nonatomic, retain) UNDUser *user;
@property (nullable, nonatomic, retain) NSSet<UNDPromiseWeb *> *promiseWeb;

@end

@interface UNDFriend (CoreDataGeneratedAccessors)

- (void)addPromiseWebObject:(UNDPromiseWeb *)value;
- (void)removePromiseWebObject:(UNDPromiseWeb *)value;
- (void)addPromiseWeb:(NSSet<UNDPromiseWeb *> *)values;
- (void)removePromiseWeb:(NSSet<UNDPromiseWeb *> *)values;

@end

NS_ASSUME_NONNULL_END
