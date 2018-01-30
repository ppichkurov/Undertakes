//
//  UNDHomeViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 28.01.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDHomeViewController.h"
#import "masonry.h"

@interface UNDHomeViewController ()

@property (nonatomic, strong) UICollectionView *allPromisesCollectionView;
@property (nonatomic, strong) UIButton *addNewPromiseButton;

@end

@implementation UNDHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareUI];
    
}

- (void)prepareUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addNewPromiseButton = [[UIButton alloc] init];
    [self.addNewPromiseButton setTitle:@"#Обещание" forState:UIControlStateNormal];
    self.addNewPromiseButton.titleLabel.font = [UIFont systemFontOfSize: 20.0f];
    [self.addNewPromiseButton setTitleColor: [UIColor colorWithRed:0 green:153/255.0f blue:153/255.0f alpha:1] forState:UIControlStateNormal];

    self.addNewPromiseButton.layer.borderWidth = 1;
    self.addNewPromiseButton.layer.borderColor = [UIColor colorWithRed:0 green:153/255.0f blue:153/255.0f alpha:1].CGColor;
    
    self.addNewPromiseButton.layer.cornerRadius = 7;
    
    [self.view addSubview:self.addNewPromiseButton];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(35, 10, 400, 10);
    
    [self.addNewPromiseButton mas_makeConstraints: ^(MASConstraintMaker *make){
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.size.mas_equalTo(44);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
    }];

     
    
}

#pragma mark - StatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - Constraints

@end
