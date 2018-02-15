//
//  UNDMaintainersCollectionViewModel.m
//  Undertakes
//
//  Created by Павел Пичкуров on 04.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDMaintainerCollectionViewDelegate.h"
#import "UNDMaintainerCollectionViewCell.h"
#import "UNDLikeMan+CoreDataClass.h"
#import "UNDCoreDataRequestService.h"
#import "UNDPromiseWeb+CoreDataClass.h"

static NSString *maintainerCollViewCell = @"maintainerCollViewCell";


@interface UNDMaintainerCollectionViewDelegate () <NSFetchedResultsControllerDelegate>

//@property (nonatomic, strong) NSFetchedResultsController *maintainerResultsController;
@property (nonatomic, weak) UICollectionView *maintainersCollectionView;

@end


@implementation UNDMaintainerCollectionViewDelegate

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
{
    if (self = [super init])
    {
        _promiseThatHaveLikes = nil;
        _maintainersCollectionView = collectionView;
    }
    return self;
}

- (BOOL)isPromiseValid
{
    if (!self.promiseThatHaveLikes
        || !self.promiseThatHaveLikes.webVersion
        || !self.promiseThatHaveLikes.webVersion.likeMans)
    {
        return NO;
    }
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (![self isPromiseValid])
    {
        return 0;
    }
    return self.promiseThatHaveLikes.webVersion.likeMans.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self isPromiseValid])
    {
        return nil;
    }
    UNDMaintainerCollectionViewCell *cell = (UNDMaintainerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:maintainerCollViewCell forIndexPath:indexPath];
    NSString *photoURLString = [self.promiseThatHaveLikes.webVersion.likeMans allObjects][indexPath.item].photo;
    //NSLog(@"%@", [self.promiseThatHaveLikes.webVersion.likeMans allObjects][indexPath.item]);
    NSString *vkID = [self.promiseThatHaveLikes.webVersion.likeMans allObjects][indexPath.item].vkID;
    cell.maintainerImagePath = photoURLString;
    cell.vkID = vkID;
    return cell;
}

@end
