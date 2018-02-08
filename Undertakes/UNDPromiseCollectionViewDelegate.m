//
//  UNDPromiseCollectionViewDelegate.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDPromiseCollectionViewDelegate.h"
#import "UNDPromiseCollectionViewCell.h"
#import "UNDUserPromisesModel.h"
#import "UNDPromise+CoreDataClass.h"

static NSString *promiseCollViewCell = @"promiseCollViewCell";

@interface UNDPromiseCollectionViewDelegate ()

@property (nonatomic, copy) UNDUserPromisesModel *promisesModel;

@end

@implementation UNDPromiseCollectionViewDelegate

- (instancetype)init
{
    if (self = [super init])
    {
        _promisesModel = [UNDUserPromisesModel new];
//        _testArray = @[@1,@2,@3,@1,@3,@5,@1,@5];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.promisesModel.promisesArray.count; //возможно нужно сразу использовать
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UNDPromiseCollectionViewCell *cell = (UNDPromiseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:promiseCollViewCell forIndexPath:indexPath];
    
//    cell.importance = self.testArray[indexPath.item];
    
    UNDPromise *promise = self.promisesModel.promisesArray[indexPath.item];
    
    cell.importance = promise.importance;
    cell.title = promise.title;
    
    return cell;
}

@end
