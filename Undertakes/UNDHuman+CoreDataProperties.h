//
//  UNDHuman+CoreDataProperties.h
//  Undertakes
//
//  Created by Павел Пичкуров on 11.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//
//

#import "UNDHuman+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UNDHuman (CoreDataProperties)

+ (NSFetchRequest<UNDHuman *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *photo;
@property (nullable, nonatomic, copy) NSString *vkID;

@end

NS_ASSUME_NONNULL_END
