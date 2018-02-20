//
//  UNDDetailViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 14.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDDetailViewController.h"
#import "NSDate+UNDStringPresentation.h"
#import "UNDTemplatesUI.h"
#import "UNDPromiseWeb+CoreDataClass.h"
#import "UNDLikeMan+CoreDataClass.h"
#import "masonry.h"

@interface UNDDetailViewController ()

@property (nonatomic, strong) UIView *subView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *fullTextView;
@property (nonatomic, strong) UILabel *startDateLabel;
@property (nonatomic, strong) UILabel *fireDateLabel;
@property (nonatomic, strong) UILabel *daysToEndLabel;
@property (nonatomic, strong) UILabel *likeCountLabel;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UNDPromise *detailedPromise;

@end

@implementation UNDDetailViewController

- (instancetype)initWithPromise:(UNDPromise *)promise
{
    if (self = [super init])
    {
        _detailedPromise = promise;
    }
    return self;
}


#pragma mark - Life circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareUI];
    [self prepareTextView];
    [self prepareLabels];
    [self prepareButtons];
    [self prepareConstraints];
}


#pragma mark - UI init

- (void)prepareUI
{
    self.subView = [UIView new];
    self.view.backgroundColor = [UNDTemplatesUI colorForImportance:_detailedPromise.importance];
    self.subView.backgroundColor = UIColor.whiteColor;
    self.subView.alpha = 0.8;
    [self.view addSubview:_subView];
}

- (void)prepareTextView
{
    self.fullTextView = [UITextView new];
    self.fullTextView.text = self.detailedPromise.fullText;
    self.fullTextView.font = [UIFont systemFontOfSize:17];
    self.fullTextView.editable = NO;
    [self.view addSubview:self.fullTextView];
}

- (void)prepareLabels
{
    self.titleLabel = [UNDTemplatesUI getLabel:self.detailedPromise.title
                                       forView:self.subView];
    self.startDateLabel = [UNDTemplatesUI getLabel: [self.detailedPromise.startDate und_toString] forView:self.subView];
    self.fireDateLabel = [UNDTemplatesUI getLabel: [self.detailedPromise.fireDate und_toString] forView:self.subView];
    self.likeCountLabel = [UNDTemplatesUI getLabel: [NSString stringWithFormat: @"%lu",[self.detailedPromise.webVersion.likeMans count]] forView:self.subView];
    
    self.titleLabel.font = [UIFont systemFontOfSize:24];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

- (void)prepareButtons
{
    self.backButton = [UNDTemplatesUI getButtonWithTitle:@"Назад"
                                              action:@selector(dismissDetailView)
                                              target:self
                                             forView:_subView];
    
    self.deleteButton = [UNDTemplatesUI getButtonWithTitle:@"Удалить"
                                                action:@selector(deletePromise)
                                                target:self
                                               forView:_subView];
}


#pragma mark - Constraints

- (void)prepareConstraints
{
    UIEdgeInsets paddings = UIEdgeInsetsMake(0, 3, 0, 0);
    UIEdgeInsets paddingTopItem = UIEdgeInsetsMake(45, 15, 20, 15);
    UIEdgeInsets paddingMiddleItem = UIEdgeInsetsMake(50, 15, 20, 15);
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(paddings);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subView.mas_top).with.offset(paddingTopItem.top);
        make.left.equalTo(self.subView.mas_left).with.offset(paddingTopItem.left);
        make.right.equalTo(self.subView.mas_right).with.offset(-paddingTopItem.right);
    }];
    
    [self.startDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.fireDateLabel.mas_top).with.offset(-paddingMiddleItem.bottom);
        make.right.equalTo(self.subView.mas_right).with.offset(-paddingMiddleItem.right);
    }];
    
    [self.fireDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.deleteButton.mas_top).with.offset(-paddingMiddleItem.bottom);
        make.right.equalTo(self.subView.mas_right).with.offset(-paddingMiddleItem.right);
    }];
    
    [self.backButton mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.subView.mas_bottom).with.offset(-paddingMiddleItem.bottom);
         make.right.equalTo(self.subView.mas_right).with.offset(-paddingMiddleItem.right);
         make.height.equalTo(@44);
         make.width.equalTo(@140);
     }];
    
    [self.deleteButton mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.subView.mas_bottom).with.offset(-paddingMiddleItem.bottom);
         make.left.equalTo(self.subView.mas_left).with.offset(paddingMiddleItem.left);
         make.right.equalTo(self.backButton.mas_left).with.offset(-paddingMiddleItem.right);
         make.height.equalTo(@44);
     }];
    
    [self.fullTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.subView.mas_left).with.offset(paddingMiddleItem.left);
        make.right.equalTo(self.subView.mas_right).with.offset(-paddingMiddleItem.right);
        make.bottom.equalTo(self.startDateLabel.mas_top).with.offset(-paddingMiddleItem.bottom);
    }];
}


#pragma mark - Button actions

- (void)deletePromise
{
    
    // удаление обещания
    
    [self dismissDetailView];
}

- (void)dismissDetailView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
