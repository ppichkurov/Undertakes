//
//  UNDAlreadyDoneTableViewCell.h
//  Undertakes
//
//  Created by Павел Пичкуров on 20.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UNDPromise+CoreDataClass.h"

@interface UNDAlreadyDoneTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *fullText;
@property (nonatomic, copy) NSDate *fireDate;
@property (nonatomic, assign) int64_t importance;
@property (nonatomic, weak) UNDPromise *promiseObject;

@end