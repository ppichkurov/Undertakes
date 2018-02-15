//
//  UNDPromiseWeb+CoreDataProperties.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDPromiseWeb+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDPromiseWeb (CoreDataProperties)

+ (NSFetchRequest<UNDPromiseWeb *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *fieldVkID;
@property (nullable, nonatomic, retain) NSSet<UNDLikeMan *> *likeMans;
@property (nullable, nonatomic, retain) UNDPromise *localVersion;
@property (nullable, nonatomic, retain) UNDFriend *friendOwner;

@end

@interface UNDPromiseWeb (CoreDataGeneratedAccessors)

- (void)addLikeMansObject:(UNDLikeMan *)value;
- (void)removeLikeMansObject:(UNDLikeMan *)value;
- (void)addLikeMans:(NSSet<UNDLikeMan *> *)values;
- (void)removeLikeMans:(NSSet<UNDLikeMan *> *)values;

@end

NS_ASSUME_NONNULL_END
