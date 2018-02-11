//
//  UNDPromisesCollectionViewDelegate.h
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UICollectionView.h>
#import "UNDPromiseDataSourceOutputProtocol.h"

@interface UNDPromiseCollectionViewDelegate : NSObject <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) id<UNDPromiseDataSourceOutputProtocol> output;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end
