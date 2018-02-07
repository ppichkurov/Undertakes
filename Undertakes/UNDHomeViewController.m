//
//  UNDHomeViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 28.01.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDHomeViewController.h"

#import "UNDPromiseCollectionViewDelegate.h"
#import "UNDMaintainerCollectionViewDelegate.h"

#import "UNDPromiseCollectionViewCell.h"
#import "UNDMaintainerCollectionViewCell.h"

#import "masonry.h"

static NSString *UNDPromiseCollViewCellId = @"promiseCollViewCell";
static NSString *UNDMaintainerCollViewCellId = @"maintainerCollViewCell";

@interface UNDHomeViewController ()

@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) UIButton *addNewPromiseButton;
@property (nonatomic, strong) UICollectionView *promisesCollectionView;
@property (nonatomic, strong) UICollectionView *maintainersCollectionView;
@property (nonatomic, strong) id <UICollectionViewDelegate, UICollectionViewDataSource> promisesDelegate;
@property (nonatomic, strong) id <UICollectionViewDelegate, UICollectionViewDataSource> maintainersDelegate;

@end


@implementation UNDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareButton];
    [self preparePromisesCollectionView];
    [self prepareMaintainersCollectionView];
    [self prepareConstraints];
}

- (void)prepareButton
{
    self.addNewPromiseButton = [[UIButton alloc] init];
    
    [self.addNewPromiseButton setTitle:@"#Дать обещание" forState:UIControlStateNormal];
    [self.addNewPromiseButton setTitleColor: [UIColor colorWithRed:0
                                                             green:153/255.0f
                                                              blue:153/255.0f
                                                             alpha:1]
                                   forState: UIControlStateNormal];
    self.addNewPromiseButton.layer.borderWidth = 1;
    self.addNewPromiseButton.layer.borderColor = [UIColor colorWithRed:0
                                                                 green:153/255.0f
                                                                  blue:153/255.0f
                                                                 alpha:1].CGColor;
    self.addNewPromiseButton.layer.cornerRadius = 7;
    
    [self.view addSubview: self.addNewPromiseButton];
}

- (void)preparePromisesCollectionView
{
    self.promisesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self propmiseFlowLayout]];
    self.promisesCollectionView.backgroundColor = UIColor.whiteColor;
    self.promisesCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    self.promisesDelegate = [UNDPromiseCollectionViewDelegate new];
    
    self.promisesCollectionView.delegate = self.promisesDelegate;
    self.promisesCollectionView.dataSource = self.promisesDelegate;
    
    [self.promisesCollectionView registerClass: [UNDPromiseCollectionViewCell class] forCellWithReuseIdentifier:UNDPromiseCollViewCellId];
    
    [self.view addSubview:self.promisesCollectionView];
}

- (void)prepareMaintainersCollectionView
{
    self.maintainersCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[self maintainerFlowLayout]];
    self.maintainersCollectionView.backgroundColor = UIColor.whiteColor;
    self.maintainersCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    
    self.maintainersDelegate = [UNDMaintainerCollectionViewDelegate new];
    
    self.maintainersCollectionView.delegate = self.maintainersDelegate;
    self.maintainersCollectionView.dataSource = self.maintainersDelegate;
    
    [self.maintainersCollectionView registerClass: [UNDMaintainerCollectionViewCell class] forCellWithReuseIdentifier:UNDMaintainerCollViewCellId];
    
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
        make.height.equalTo(@44);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
    }];
    
    [self.promisesCollectionView mas_makeConstraints: ^(MASConstraintMaker *make)
    {
        make.top.equalTo(self.addNewPromiseButton.mas_bottom).with.offset(30.0f);
        make.right.equalTo(self.view.mas_right).with.offset(15.0f);
        make.left.equalTo(self.view.mas_left).with.offset(15.0f);
        make.height.equalTo(@200);
    }];
    
    [self.maintainersCollectionView mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.promisesCollectionView.mas_bottom).with.offset(30.0f);
         make.right.equalTo(self.view.mas_right).with.offset(15.0f);
         make.left.equalTo(self.view.mas_left).with.offset(15.0f);
         make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
     }];
}

@end
