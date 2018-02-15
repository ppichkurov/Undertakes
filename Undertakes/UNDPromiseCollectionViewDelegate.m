//
//  UNDPromiseCollectionViewDelegate.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDPromiseCollectionViewDelegate.h"
#import "UNDPromiseCollectionViewCell.h"
#import "UNDPromise+CoreDataClass.h"
#import "UNDCoreDataRequestService.h"

static NSString *promiseCollViewCell = @"promiseCollViewCell";

@interface UNDPromiseCollectionViewDelegate () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *promiceResultsController;
@property (nonatomic, weak) UICollectionView *promisesCollectionView;

@end

@implementation UNDPromiseCollectionViewDelegate

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    if (self = [super init])
    {
        _promiceResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:[UNDCoreDataRequestService userPromisesRequest]
                                     managedObjectContext:[UNDCoreDataRequestService coreDataContext]
                                     sectionNameKeyPath:nil
                                     cacheName:nil];
        _promiceResultsController.delegate = self;
        _promisesCollectionView = collectionView;
        [_promiceResultsController performFetch:nil];
    }
    return self;
}


- (void)prepareCell: (UNDPromiseCollectionViewCell *) cell withPromise:(UNDPromise *)promise
{
    if (!cell || !promise)
    {
        return;
    }
    cell.title = promise.title;
    cell.fullText = promise.fullText;
    cell.importance = promise.importance;
    cell.promiseObject = promise;
    
    //TODO передавать только объект и настраивать внутри cell?
}


#pragma mark - NSFetchedResultsController delegate

- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return @"Ваши обещания";
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
        {
            [self.promisesCollectionView performBatchUpdates:^{
                [self.promisesCollectionView insertItemsAtIndexPaths:@[newIndexPath]];
            } completion:nil];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            [self.promisesCollectionView performBatchUpdates:^{
                [self.promisesCollectionView deleteItemsAtIndexPaths:@[indexPath]];
            } completion:nil];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self prepareCell:(UNDPromiseCollectionViewCell *)[self.promisesCollectionView cellForItemAtIndexPath:indexPath]
                  withPromise:anObject];
            break;
        }
        case NSFetchedResultsChangeMove:
            [self.promisesCollectionView performBatchUpdates:^{
                [self.promisesCollectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
            } completion:nil];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.promisesCollectionView reloadData];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.promiceResultsController.sections[section].numberOfObjects;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


#pragma mark - UICollectionViewDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UNDPromiseCollectionViewCell *cell = (UNDPromiseCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:promiseCollViewCell forIndexPath:indexPath];
    
     UNDPromise *promise = [self.promiceResultsController objectAtIndexPath:indexPath];
    [self prepareCell:cell withPromise:promise];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self choosePromiseForLikeDisplay];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self choosePromiseForLikeDisplay];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UNDPromise *promise = [self.promiceResultsController objectAtIndexPath:indexPath];
    [self.output presentPromise: promise];
}

#pragma mark - Choose cell logic

- (void)choosePromiseForLikeDisplay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray<UNDPromiseCollectionViewCell *> *arrayOfVisibleCells = [self.promisesCollectionView visibleCells];
        if (!arrayOfVisibleCells)
        {
            return;
        }
        CGFloat collectionWidth = CGRectGetWidth(self.promisesCollectionView.frame);
        CGFloat contentOffset = self.promisesCollectionView.contentOffset.x;
        for (UNDPromiseCollectionViewCell *cell in arrayOfVisibleCells) {
            if (CGRectGetMinX(cell.frame) >= contentOffset
                && CGRectGetMaxX(cell.frame) <= contentOffset + collectionWidth)
            {
                [self.output changeCurrentMaintainerCollectionForPromise: cell.promiseObject];
                return;
            }
        }
    });
}

- (void)maintainersNeedToInit
{ 
    [self choosePromiseForLikeDisplay];
}

@end
