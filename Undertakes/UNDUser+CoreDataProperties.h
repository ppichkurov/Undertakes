//
//  UNDUser+CoreDataProperties.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDUser (CoreDataProperties)

+ (NSFetchRequest<UNDUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *freeTime;
@property (nullable, nonatomic, copy) NSString *token;
@property (nullable, nonatomic, retain) NSSet<UNDFriend *> *friends;

@end

@interface UNDUser (CoreDataGeneratedAccessors)

- (void)addFriendsObject:(UNDFriend *)value;
- (void)removeFriendsObject:(UNDFriend *)value;
- (void)addFriends:(NSSet<UNDFriend *> *)values;
- (void)removeFriends:(NSSet<UNDFriend *> *)values;

@end

NS_ASSUME_NONNULL_END
