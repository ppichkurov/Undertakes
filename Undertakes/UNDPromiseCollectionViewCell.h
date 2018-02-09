//
//  UNDPromiseCollectionViewCell.h
//  Undertakes
//
//  Created by Павел Пичкуров on 03.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UNDPromiseCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *fullText;
@property (nonatomic, copy) NSDate *fireDate;
@property (nonatomic, assign) int64_t importance;

@end
