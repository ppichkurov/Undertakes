//
//  UNDAlreadyDoneTableViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 14.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAlreadyDoneTableViewController.h"
#import "UNDCoreDataRequestService.h"
#import "UNDPromise+CoreDataClass.h"
#import "UNDAlreadyDoneTableViewCell.h"
#import "UNDCoreDataService.h"
#import "UNDTemplatesUI.h"


static NSString *UNDOldPromisesTableViewReuseID = @"oldPromisesTableViewReuseID";
static const CGFloat UNDTableViewRowHeight = 150.0f;

@interface UNDAlreadyDoneTableViewController () <NSFetchedResultsControllerDelegate>


@property (nonatomic, strong) NSFetchedResultsController *oldPromiseResultsController;
@property (nonatomic, strong) UNDCoreDataService *coreDataService;

@end

@implementation UNDAlreadyDoneTableViewController

- (instancetype)init
{
    if (self = [super init])
    {
        self.view.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
        self.tableView.allowsSelection = NO;
        self.coreDataService = [UNDCoreDataService new];
    }
    return self;
}

- (NSFetchedResultsController *)oldPromiseResultsController;
{
    if (_oldPromiseResultsController)
    {
        return _oldPromiseResultsController;
    }
    _oldPromiseResultsController = [[NSFetchedResultsController alloc]
                                    initWithFetchRequest:[UNDCoreDataRequestService userPromisesRequest:NO]
                                    managedObjectContext:[UNDCoreDataRequestService coreDataContext]
                                    sectionNameKeyPath:nil
                                    cacheName:nil];
    _oldPromiseResultsController.delegate = self;
    [_oldPromiseResultsController performFetch:nil];
    return _oldPromiseResultsController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UNDAlreadyDoneTableViewCell class]
           forCellReuseIdentifier: UNDOldPromisesTableViewReuseID];
    [self prepareRefreshControl];
    self.tableView.rowHeight = UNDTableViewRowHeight;
}

- (void)prepareRefreshControl
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshData)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)refreshData
{
    self.oldPromiseResultsController = nil;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)prepareCell:(UNDAlreadyDoneTableViewCell *)cell withPromise:(UNDPromise *)promise
{
    if (!cell || !promise)
    {
        return;
    }
    cell.title = promise.title;
    cell.fullText = promise.fullText;
    cell.importance = promise.importance;
    cell.promiseObject = promise;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %lu", self.oldPromiseResultsController.sections[section].numberOfObjects);
    return self.oldPromiseResultsController.sections[section].numberOfObjects;
}


#pragma mark - Table view delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UNDAlreadyDoneTableViewCell *cell = (UNDAlreadyDoneTableViewCell *)[tableView dequeueReusableCellWithIdentifier:UNDOldPromisesTableViewReuseID forIndexPath:indexPath];
  
    if (!cell) {
        cell = [[UNDAlreadyDoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                  reuseIdentifier:UNDOldPromisesTableViewReuseID];
    }
    UNDPromise *promise = [self.oldPromiseResultsController objectAtIndexPath:indexPath];
    [self prepareCell:cell withPromise:promise];
    return cell;
}


#pragma mark - NSFetchedResultControllerDelegate

- (NSString *)controller:(NSFetchedResultsController *)controller sectionIndexTitleForSectionName:(NSString *)sectionName
{
    return sectionName;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            [self prepareCell:[self.tableView cellForRowAtIndexPath:indexPath] withPromise:anObject];
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
