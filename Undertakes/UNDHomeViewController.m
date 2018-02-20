//
//  UNDHomeViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 28.01.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDHomeViewController.h"
#import "UIButton+UNDButtonAnimation.h"
#import "UNDPromiseWeb+CoreDataClass.h"

#import "UNDPromiseCollectionViewDelegate.h"
#import "UNDMaintainerCollectionViewDelegate.h"

#import "UNDPromiseCollectionViewCell.h"
#import "UNDMaintainerCollectionViewCell.h"

#import "UNDAddPromiceViewController.h"
#import "UNDDetailViewController.h"

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
@property (nonatomic, strong) UNDNetworkParser *networkParser; //TODO должен работать только с нетворком
@property (nonatomic, strong) UNDNetworkService *networkService;

@property (nonatomic, weak) UNDPromise *currentPromise;
@property (nonatomic, assign) NSUInteger countOfPhotoNeedWaitingFor;

@end

@implementation UNDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareUI];
    [self prepareButtons];
    [self preparePromisesCollectionView];
    [self prepareMaintainersCollectionView];
    [self prepareConstraints];
    [self prepareParser];
    [self prepareNetworkService];    
}

- (void)prepareUI
{
    self.view.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
    self.countOfPhotoNeedWaitingFor = 0;
}

- (void)prepareButtons
{
    self.addNewPromiseButton = [UNDTemplatesUI getButtonWithTitle:@"#Дать обещание"
                                                           action:@selector(addNewPromice)
                                                           target:self
                                                          forView:self.view];
    self.refreshLikesButton = [UNDTemplatesUI getButtonWithTitle:@"#Fresh"
                                                          action:@selector(refreshLikes)
                                                          target:self
                                                         forView:self.view];
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
        [self.refreshLikesButton und_startFailAnimation];
        return;
    }
    if (!self.currentPromise.webVersion)
    {
        [self.refreshLikesButton und_startFailAnimation];
        return;
    }
    [self.networkService getUsersThatLikeField: self.currentPromise.webVersion.fieldVkID.intValue];
    [self.refreshLikesButton setTitleColor: self.refreshLikesButton.backgroundColor forState:UIControlStateNormal];
    [self.refreshLikesButton und_startRefreshAnimation];
}

- (void)preparePromisesCollectionView
{
    self.promisesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                     collectionViewLayout:[self propmiseFlowLayout]];
    self.promisesCollectionView.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
    self.promisesCollectionView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    self.promisesDelegate = [[UNDPromiseCollectionViewDelegate alloc]
                             initWithCollectionView:self.promisesCollectionView];
    self.promisesCollectionView.delegate = self.promisesDelegate;
    self.promisesCollectionView.dataSource = self.promisesDelegate;
    self.promisesDelegate.output = self;
    [self.promisesCollectionView registerClass: [UNDPromiseCollectionViewCell class]
                    forCellWithReuseIdentifier:UNDPromiseCollViewCellId];
    [self.view addSubview:self.promisesCollectionView];
}

- (void)prepareMaintainersCollectionView
{
    self.maintainersCollectionView = [[UICollectionView alloc]
                                      initWithFrame:CGRectZero collectionViewLayout:[self maintainerFlowLayout]];
    self.maintainersCollectionView.backgroundColor = [UNDTemplatesUI getMainBackgroundColor];
    self.maintainersCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.maintainersDelegate = [UNDMaintainerCollectionViewDelegate new];
    self.maintainersCollectionView.delegate = self.maintainersDelegate;
    self.maintainersCollectionView.dataSource = self.maintainersDelegate;
    [self.maintainersCollectionView registerClass: [UNDMaintainerCollectionViewCell class]
                       forCellWithReuseIdentifier:UNDMaintainerCollViewCellId];
    [self.view addSubview:self.maintainersCollectionView];
}

//нет смысла объединять методы, будет слишком много параметров
- (UICollectionViewFlowLayout *)propmiseFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumInteritemSpacing = 10.0f; //отступ между столбцами
    flowLayout.minimumLineSpacing = 10.0f; // отступ между строками
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    flowLayout.itemSize = CGSizeMake(200, 200);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return flowLayout;
}

- (UICollectionViewFlowLayout *)maintainerFlowLayout
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumInteritemSpacing = 15.0f; //отступ между столбцами
    flowLayout.minimumLineSpacing = 20.0f; // отступ между строками
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
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
    NSLog(@"tabbar: %f", CGRectGetHeight(self.tabBarController.tabBar.frame));
    
    UIEdgeInsets padding = UIEdgeInsetsMake(45, 15, 0, 15);
    [self.addNewPromiseButton mas_makeConstraints: ^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
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
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@220);
    }];
    
    [self.maintainersCollectionView mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.promisesCollectionView.mas_bottom).with.offset(20.0f);
         make.right.equalTo(self.view.mas_right);
         make.left.equalTo(self.view.mas_left);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(-CGRectGetHeight(self.tabBarController.tabBar.frame));
     }];
}


#pragma mark - UNDPromiseDataSourceOutputProtocol


- (void)changeCurrentMaintainerCollectionForPromise:(UNDPromise *)promise
{
    self.currentPromise = promise;
    self.maintainersDelegate.promiseThatHaveLikes = promise;
    self.networkParser.currentPromiseID = promise.objectID;
    [self.maintainersCollectionView reloadData];
}

- (void)addPromisCollectionViewWillDismissed:(NSString *)title fulltext:(NSString *)fullText
{
    [self.networkService createPromiseOnTheUserWallWithTitle:title fulltext:fullText];
}

- (void)presentPromise:(UNDPromise *)promise
{
    UNDDetailViewController *detailViewController = [[UNDDetailViewController alloc] initWithPromise:promise];
    [self presentViewController:detailViewController animated:YES completion:^{
        NSLog(@"show details");
    }];
}

//вынести в отдельный сервис
//------------------------------------------------------------------------------------

- (void)listOfMansThatLikedPromise:(NSSet *)likeMans
{
    self.countOfPhotoNeedWaitingFor = likeMans.count;
    for (NSNumber *man in likeMans) {
        [self.networkService getUserPhotoURL:man.intValue];
    }
}

- (void)photosURLOfMan:(NSUInteger)userID thatLikedPromiseReceived:(NSString *)urlString
{
    [self.networkService getPhotoByURL:urlString userID:userID];
}

- (void)photoLoad
{
    self.countOfPhotoNeedWaitingFor--;
    if (self.countOfPhotoNeedWaitingFor == 0)
    {
        NSLog(@"All photo received");
        [self.maintainersCollectionView reloadData];
    }
}
//------------------------------------------------------------------------------------

@end
