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
        [_promiceResultsController performFetch:nil];
//        _testArray = @[@1,@2,@3,@1,@3,@5,@1,@5];
    }
    return self;
}


- (void)prepareCell: (UNDPromiseCollectionViewCell *) cell withPromise: (UNDPromise *)promise
{
    if (!cell || !promise)
    {
        return;
    }
    cell.importance = promise.importance;
    cell.title = promise.title;
    cell.fullText = promise.fullText;
}

#pragma mark - NSFetchedResultsController delegate

- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return @"Ваши обещания"; //заменить на свое название?
}

//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
////    [self.promisesCollectionView ];
//}

//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
//{
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.promisesCollectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
//            break;
//
//        case NSFetchedResultsChangeDelete:
//            [self.promisesCollectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
//            break;
//
//        default:
//            return;
//    }
//}

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
            [self.promisesCollectionView deleteItemsAtIndexPaths:@[indexPath]];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self prepareCell:(UNDPromiseCollectionViewCell *)[self.promisesCollectionView cellForItemAtIndexPath:indexPath]
                  withPromise:anObject];
            break;
        }
        case NSFetchedResultsChangeMove:
            [self.promisesCollectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
//    [self.promisesCollectionView reloadSections: [NSIndexSet indexSetWithIndex:0]];
//}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    return self.promisesModel.promisesArray.count;
    NSLog(@"Count: %lu", self.promiceResultsController.sections[section].numberOfObjects);
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

@end
