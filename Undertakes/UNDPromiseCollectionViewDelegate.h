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

/**
 * <p>Конструктор принимает указатель на коллекцию, чьим делегатом и датасурсом является</p>
 * @param collectionView - держится weak ссылка на коллекцию
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

/**
 * <p>Сигнализирует о необходимости определения текущего обещания на экране при загрузке контроллера</p>
 */
- (void)maintainersNeedToInit;

@end
