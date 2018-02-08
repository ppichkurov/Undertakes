//
//  UNDUser+CoreDataProperties.h
//  
//
//  Created by Павел Пичкуров on 08.02.2018.
//
//

#import "UNDUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDUser (CoreDataProperties)

+ (NSFetchRequest<UNDUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *freeTime;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nonatomic) int64_t vkID;

@end

NS_ASSUME_NONNULL_END
