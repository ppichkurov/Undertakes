//
//  UNDAddPromiceViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAddPromiceViewController.h"
#import "UIButton+UNDButtonAnimation.h"
#import "UNDCoreDataService.h"
#import "UNDTemplatesUI.h"
#import "masonry.h"


/**
 для тестов - сделана 1 минута вместо дня (60 * 60 * 24)
 */
static const NSTimeInterval UNDTomorrow = 60;


@interface UNDAddPromiceViewController ()


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UILabel *whyLabel;
@property (nonatomic, strong) UITextField *fullText;
@property (nonatomic, strong) UILabel *importanceLabel;
@property (nonatomic, strong) UISlider *importanceSlider;
@property (nonatomic, assign) int64_t importance;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UNDCoreDataService *coreDataService;

@end

@implementation UNDAddPromiceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.coreDataService = [UNDCoreDataService new];
    
    [self prepareTitleLabel];
    [self prepareTitleText];
    [self prepareWhyLabel];
    [self prepareFullText];
    [self prepareImportanceLabel];
    [self prepareImportanceSlider];
    [self prepareDateLabel];
    [self prepareDatePicker];
    [self prepareButtons];
    [self prepareConstraints];
}

- (void)prepareTitleLabel
{
    self.titleLabel = [UILabel new];
    self.titleLabel.text = @"Я хочу";
    self.titleLabel.textColor = UIColor.blackColor;
    [self.view addSubview: self.titleLabel];
}

- (void)prepareTitleText
{
    self.titleText = [UITextField new];
    self.titleText.borderStyle = UITextBorderStyleRoundedRect;
    self.titleText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: self.titleText];
}

- (void)prepareWhyLabel
{
    self.whyLabel = [UILabel new];
    self.whyLabel.text = @"Потому что";
    [self.view addSubview: self.whyLabel];
}

- (void)prepareFullText
{
    self.fullText = [UITextField new];
    self.fullText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview: self.fullText];
}

- (void)prepareImportanceLabel
{
    self.importanceLabel = [UILabel new];
    self.importanceLabel.text = @"Это важно для меня";
    [self.view addSubview: self.importanceLabel];
}

- (void)prepareImportanceSlider
{
    self.importanceSlider = [UISlider new];
    self.importanceSlider.minimumValue = 1;
    self.importanceSlider.maximumValue = 5;
    self.importanceSlider.value = 1;
    self.importance = 1;
    
    [self.importanceSlider addTarget:self
                              action:@selector(changeImportance)
                    forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview: self.importanceSlider];
}

- (void)prepareDateLabel
{
    self.dateLabel = [UILabel new];
    self.dateLabel.text = @"Хочу закончить";
    [self.view addSubview: self.dateLabel];
}

- (void)prepareDatePicker
{
    self.datePicker = [UIDatePicker new];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow: UNDTomorrow];
    [self.view addSubview:self.datePicker];
}

- (void)prepareButtons
{
    self.addButton = [UNDTemplatesUI getButtonWithTitle:@"#Действовать"
                                                 action:@selector(backToMainView)
                                                 target:self
                                                forView:self.view];
    
    self.backButton = [UNDTemplatesUI getButtonWithTitle:@"#Back"
                                                  action:@selector(backWithoutSave)
                                                  target:self
                                                 forView:self.view];
}


#pragma mark - Constraints

- (void)prepareConstraints
{
    UIEdgeInsets paddingTopItem = UIEdgeInsetsMake(45, 15, 0, 15);
    UIEdgeInsets paddingMiddleItem = UIEdgeInsetsMake(15, 15, 30, 15);
    
    [self.titleLabel mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.view.mas_top).with.offset(paddingTopItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
     }];
    
    [self.titleText mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.titleLabel.mas_bottom).with.offset(paddingMiddleItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
         make.width.equalTo(@250);
     }];
    
    [self.whyLabel mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.titleText.mas_bottom).with.offset(paddingMiddleItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
     }];
    
    [self.fullText mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.whyLabel.mas_bottom).with.offset(paddingMiddleItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
         make.width.equalTo(@250);
     }];
    
    [self.importanceLabel mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.fullText.mas_bottom).with.offset(paddingMiddleItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
     }];
    
    [self.importanceSlider mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.importanceLabel.mas_bottom).with.offset(paddingMiddleItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
         make.width.equalTo(@250);
     }];
    
    [self.dateLabel mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.importanceSlider.mas_bottom).with.offset(paddingMiddleItem.top);
         make.centerX.equalTo(self.view.mas_centerX);
     }];
    
    [self.datePicker mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.top.equalTo(self.dateLabel.mas_bottom).with.offset(paddingMiddleItem.top);
         make.width.equalTo(self.view.mas_width);
         make.height.equalTo(@160);
     }];
    
    [self.addButton mas_makeConstraints: ^(MASConstraintMaker *make)
    {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-paddingMiddleItem.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-paddingMiddleItem.right);
        make.height.equalTo(@44);
        make.width.equalTo(@200);
    }];
    
    [self.backButton mas_makeConstraints: ^(MASConstraintMaker *make)
     {
         make.bottom.equalTo(self.view.mas_bottom).with.offset(-paddingMiddleItem.bottom);
         make.left.equalTo(self.view.mas_left).with.offset(paddingMiddleItem.left);
         make.right.equalTo(self.addButton.mas_left).with.offset(-paddingMiddleItem.right);
         make.height.equalTo(@44);
     }];
}

- (void)changeImportance
{
    self.importance = (int64_t)(self.importanceSlider.value + 0.5);
    self.importanceSlider.value = self.importance;
}

- (void)backToMainView
{
    if (self.titleLabel.text.length == 0
        || self.fullText.text.length == 0)
    {
        [self.addButton und_startFailAnimation];
        return;
    }
    [self savePromiseToCoreData];
    [self.delegate addPromisCollectionViewWillDismissed:self.titleText.text fulltext:self.fullText.text];
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"go BACK");
    }];
}

- (void)backWithoutSave
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"go BACK without save");
    }];
}


#pragma mark - Save before close

- (void)savePromiseToCoreData
{
    [self.coreDataService savePromiseToCoreDataWithTitle:self.titleText.text
                                             description:self.fullText.text
                                              importance:self.importance
                                                fireDate:self.datePicker.date];
}

@end
