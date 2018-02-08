//
//  UNDAddPromiceViewController.m
//  Undertakes
//
//  Created by Павел Пичкуров on 08.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDAddPromiceViewController.h"
#import "masonry.h"

static const NSTimeInterval UNDTomorrow = 60 * 60 * 24;


@interface UNDAddPromiceViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *titleText;
@property (nonatomic, strong) UILabel *whyLabel;
@property (nonatomic, strong) UITextField *fullText;
@property (nonatomic, strong) UILabel *importanceLabel;
@property (nonatomic, strong) UISlider *importanceSlider;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation UNDAddPromiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self prepareTitleLabel];
    [self prepareTitleText];
    [self prepareWhyLabel];
    [self prepareFullText];
    [self prepareImportanceLabel];
    [self prepareImportanceSlider];
    [self prepareDateLabel];
    [self prepareDatePicker];
    [self prepareAddButton];
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

- (void)prepareAddButton
{
    self.addButton = [[UIButton alloc] init];
    [self.addButton setTitle:@"#Действовать" forState:UIControlStateNormal];
    [self.addButton setTitleColor: [UIColor colorWithRed:0
                                                   green:153/255.0f
                                                    blue:153/255.0f
                                                   alpha:1]
                                       forState: UIControlStateNormal];
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.borderColor = [UIColor colorWithRed:0
                                                       green:153/255.0f
                                                        blue:153/255.0f
                                                       alpha:1].CGColor;
    self.addButton.layer.cornerRadius = 7;
    
    [self.addButton addTarget:self action:@selector(backToMainView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.addButton];
}

- (void)prepareConstraints
{
    UIEdgeInsets paddingTopItem = UIEdgeInsetsMake(35, 15, 0, 15);
    UIEdgeInsets paddingMiddleItem = UIEdgeInsetsMake(15, 15, 0, 15);
    
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
        make.top.equalTo(self.datePicker.mas_bottom).with.offset(paddingMiddleItem.top);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.equalTo(@44);
        make.width.equalTo(@200);
    }];
}

- (void)backToMainView
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"go BACK");
    }];
}

@end
