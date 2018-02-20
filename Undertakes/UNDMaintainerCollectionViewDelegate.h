//
//  UNDMaintainerCollectionViewDelegate.h
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UICollectionView.h>
#import "UNDPromise+CoreDataClass.h"


@interface UNDMaintainerCollectionViewDelegate : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>


/**
 * <p>Используется как модель</p>
 */
@property (nonatomic, weak) UNDPromise *promiseThatHaveLikes;


@end
