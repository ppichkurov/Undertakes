//
//  UNDHomeViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 28.01.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDHomeViewController.h"

#import "UNDPromiseWeb+CoreDataClass.h"

#import "UNDPromiseCollectionViewDelegate.h"
#import "UNDMaintainerCollectionViewDelegate.h"

#import "UNDPromiseCollectionViewCell.h"
#import "UNDMaintainerCollectionViewCell.h"

#import "UNDAddPromiceViewController.h"

#import "UNDNetworkParser.h"
#import "UNDNetworkService.h"
#import "UNDTemplatesUI.h"

#import "masonry.h"


#import "UNDStringConstants.h"

static NSString *UNDPromiseCollViewCellId = @"promiseCollViewCell";
static NSString *UNDMaintainerCollViewCellId = @"maintainerCollViewCell";


@interface UNDHomeViewController () <UNDPromiseDataSourceOutputProtocol, UNDParserOutputProtocol>

@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) UIButton *addNewPromiseButton;
@property (nonatomic, strong) UIButton *refreshLikesButton;
@property (nonatomic, strong) UICollectionView *promisesCollectionView;
@property (nonatomic, strong) UICollectionView *maintainersCollectionView;
@property (nonatomic, strong) UNDPromiseCollectionViewDelegate *promisesDelegate;
@property (nonatomic, strong) UNDMaintainerCollectionViewDelegate *maintainersDelegate;
@property (nonatomic, strong) UNDNetworkParser *networkParser;
@property (nonatomic, strong) UNDNetworkService *networkService;

@property (nonatomic, weak) UNDPromise *currentPromise;

@end

@implementation UNDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.grayColor;
    self.tabBarItem.title = @"Home";
    
    [self prepareButtons];
    [self preparePromisesCollectionView];
    [self prepareMaintainersCollectionView];
    [self prepareConstraints];
    [self prepareParser];
    [self prepareNetworkService];
}

- (void)prepareButtons
{
    self.addNewPromiseButton = [UNDTemplatesUI getButtonWithTitle:@"#Дать обещание"
                                                           action:@selector(addNewPromice)
                                                           target:self
                                                           toView:self.view];
    self.refreshLikesButton = [UNDTemplatesUI getButtonWithTitle:@"#Fresh"
                                                          action:@selector(refreshLikes)
                                                          target:self
                                                          toView:self.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.promisesDelegate maintainersNeedToInit];
}

- (void)prepareNetworkService
{
    self.networkService = [UNDNetworkService new];
    self.networkService.outputDelegate = self.networkParser;
}

- (void)prepareParser
{
    self.networkParser = [UNDNetworkParser new];
    self.networkParser.outputDelegate = self;
}

- (void)addNewPromice
{
    UNDAddPromiceViewController *addPromiseViewController = [UNDAddPromiceViewController new];
    addPromiseViewController.delegate = self;
    [self presentViewController: addPromiseViewController animated:YES completion:^{
        NSLog(@"go forward");
    }];
}

- (void)refreshLikes
{
    if (!self.currentPromise)
    {
        return;
    }
    if (!self.currentPromise.webVersion)
    {
        return;
    }
    [self.networkService getUsersThatLikeField: self.currentPromise.webVersion.fieldVkID.intValue];
    
    // переделать на обновления после полной подгрузки
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.maintainersCollectionView reloadData];
    });
}

- (void)preparePromisesCollectionView
{
    self.promisesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                     collectionViewLayout:[self propmiseFlowLayout]];
    self.promisesCollectionView.backgroundColor = UIColor.grayColor;
    self.promisesCollectionView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    
    self.promisesDelegate = [[UNDPromiseCollectionViewDelegate alloc]
                             initWithCollectionView:self.promisesCollectionView];
    
    self.promisesCollectionView.delegate = self.promisesDelegate;
    self.promisesCollectionView.dataSource = self.promisesDelegate;
    self.promisesDelegate.output = self;
    
//    self.promisesCollectionView.prefetchingEnabled = NO;
    
    [self.promisesCollectionView registerClass: [UNDPromiseCollectionViewCell class]
                    forCellWithReuseIdentifier:UNDPromiseCollViewCellId];
    
    [self.view addSubview:self.promisesCollectionView];
}

- (void)prepareMaintainersCollectionView
{
    self.maintainersCollectionView = [[UICollectionView alloc]
                                      initWithFrame:CGRectZero collectionViewLayout:[self maintainerFlowLayout]];
    self.maintainersCollectionView.backgroundColor = UIColor.grayColor;
    self.maintainersCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    self.maintainersDelegate = [UNDMaintainerCollectionViewDelegate new];
    
    self.maintainersCollectionView.delegate = self.maintainersDelegate;
    self.maintainersCollectionView.dataSource = self.maintainersDelegate;
    
    [self.maintainersCollectionView registerClass: [UNDMaintainerCollectionViewCell class]
                       forCellWithReuseIdentifier:UNDMaintainerCollViewCellId];
    
    [self.view addSubview:self.maintainersCollectionView];
}

- (UICollectionViewFlowLayout *)propmiseFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumInteritemSpacing = 10.0f; //отступ между столбцами
    flowLayout.minimumLineSpacing = 10.0f; // отступ между строками
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 30);
    flowLayout.itemSize = CGSizeMake(200, 200);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (UICollectionViewFlowLayout *)maintainerFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumInteritemSpacing = 0.0f; //отступ между столбцами
    flowLayout.minimumLineSpacing = 15.0f; // отступ между строками
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 30);
    flowLayout.itemSize = CGSizeMake(50, 50);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return flowLayout;
}


#pragma mark - StatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


#pragma mark - Constraints

- (void)prepareConstraints
{
    UIEdgeInsets padding = UIEdgeInsetsMake(35, 15, 0, 15);
    [self.addNewPromiseButton mas_makeConstraints: ^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
//        make.right.equalTo(self.view.mas_right).with.offset(padding.right);
//        make.centerX.equalTo(self.view.mas_centerX);

        make.width.equalTo(@180);
        make.height.equalTo(@44);
    }];
    
    [self.refreshLikesButton mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view.mas_top).with.offset(padding.top);
         make.left.equalTo(self.addNewPromiseButton.mas_right).with.offset(padding.left);
         make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
         make.height.equalTo(@44);
     }];
    
    [self.promisesCollectionView mas_makeConstraints: ^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.addNewPromiseButton.mas_bottom).with.offset(20.0f);
        make.right.equalTo(self.view.mas_right).with.offset(15.0f);
        make.left.equalTo(self.view.mas_left).with.offset(15.0f);
        make.height.equalTo(@220);
    }];
    
    [self.maintainersCollectionView mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.promisesCollectionView.mas_bottom).with.offset(20.0f);
         make.right.equalTo(self.view.mas_right).with.offset(15.0f);
         make.left.equalTo(self.view.mas_left).with.offset(15.0f);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
     }];
}


#pragma mark - UNDPromiseDataSourceOutputProtocol

- (void)changeCurrentMaintainerCollectionForPromise:(UNDPromise *)promise
{
    self.maintainersDelegate.promiseThatHaveLikes = promise;
    self.currentPromise = promise;
    self.networkParser.currentPromiseID = promise.objectID;
    [self.maintainersCollectionView reloadData];
}

- (void)addPromisCollectionViewWillDismissed:(NSString *)title fulltext:(NSString *)fullText
{
        [self.networkService createPromiseOnTheUserWallWithTitle:title fulltext:fullText];
}

- (void)listOfMansThatLikedPromise:(NSSet *)likeMans
{
    for (NSNumber *man in likeMans) {
        [self.networkService getUserPhotoURL:man.intValue];
    }
}

- (void)photosURLOfMan:(NSUInteger)userID thatLikedPromiseReceived:(NSString *)urlString
{
    [self.networkService getPhotoByURL:urlString userID:userID];
}

@end
