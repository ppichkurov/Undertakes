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
@property (nonatomic, strong) NSNumber *importance;

@end
