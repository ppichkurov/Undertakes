//
//  UNDMaintainerCollectionViewDelegate.h
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UICollectionView.h>

@interface UNDMaintainerCollectionViewDelegate : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray<NSNumber *> *testArray;

@end
