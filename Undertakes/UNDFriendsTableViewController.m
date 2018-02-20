//
//  UNDFriendsTableViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 14.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDFriendsTableViewController.h"


@interface UNDFriendsTableViewController ()


@end

@implementation UNDFriendsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareRefreshControl];
}

- (void)prepareRefreshControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshControl) forControlEvents:UIControlEventValueChanged];
    [self.tableView setRefreshControl:refreshControl];
}

- (void)refresh
{
    NSLog(@"Refresh!");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

@end
