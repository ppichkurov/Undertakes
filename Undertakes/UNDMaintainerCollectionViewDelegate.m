//
//  UNDMaintainersCollectionViewModel.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDMaintainerCollectionViewDelegate.h"
#import "UNDMaintainerCollectionViewCell.h"

static NSString *maintainerCollViewCell = @"maintainerCollViewCell";

@interface UNDMaintainerCollectionViewDelegate ()

//@property (nonatomic, strong) NSFetchedResultsController *maintainerResultsController;

@end

@implementation UNDMaintainerCollectionViewDelegate


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    if (self = [super init])
    {
//        _promisesModel = [UNDUserPromisesModel new];
//        _promiceResultsController = [[NSFetchedResultsController alloc]
//                                     initWithFetchRequest:[UNDCoreDataRequestService userPromisesRequest]
//                                     managedObjectContext:[UNDCoreDataRequestService coreDataContext]
//                                     sectionNameKeyPath:nil
//                                     cacheName:nil];
//        _promiceResultsController.delegate = self;
        _testArray = @[@1,@2,@3,@1,@3,@5,@1,@5];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.testArray.count;
    return 17;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UNDMaintainerCollectionViewCell *cell = (UNDMaintainerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:maintainerCollViewCell forIndexPath:indexPath];
    
    cell.maintainerImage = [UIImage imageNamed:@"0"];
    
    return cell;
}

@end
