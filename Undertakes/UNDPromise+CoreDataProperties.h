//
//  UNDPromise+CoreDataProperties.h
//  
//
//  Created by Павел Пичкуров on 08.02.2018.
//
//

#import "UNDPromise+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDPromise (CoreDataProperties)

+ (NSFetchRequest<UNDPromise *> *)fetchRequest;

@property (nonatomic) int64_t fieldVkID;
@property (nullable, nonatomic, copy) NSDate *fireDate;
@property (nullable, nonatomic, copy) NSString *fullText;
@property (nullable, nonatomic, copy) NSString *hashTag;
@property (nonatomic) int64_t importance;
@property (nonatomic) int64_t likeCount;
@property (nullable, nonatomic, copy) NSDate *perDayTime;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSString *title;
@property (nonatomic) int64_t userVkID;

@end

NS_ASSUME_NONNULL_END
