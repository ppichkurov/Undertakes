//
//  UNDTemplatesUITests.m
//  UndertakesTests
//
//  Created by Павел Пичкуров on 17.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UNDTemplatesUI.h"
#import "Expecta.h"
#import "OCMock.h"

@interface UNDTemplatesUI (Tests)

+ (UIColor *)getMainBackgroundColor;

+ (UIColor *)colorForImportance:(NSUInteger)importance;

+ (UIButton *)getButtonWithTitle:(NSString *)title
                          action:(SEL)selector
                          target:(id)target
                         forView:(UIView *)view;

+ (UILabel *)getLabel:(NSString *)text forView:(UIView *)view;

@end

@interface UNDTemplatesUITests : XCTestCase

@end

@implementation UNDTemplatesUITests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}


#pragma mark - + (UIButton *)getButtonWithTitle:(NSString *)title action:(SEL)selector target:(id)target forView:(UIView *)view

- (void)testGetButtonWithTitleActionTargetForViewNilTitleNilTitle
{
    id target = OCMClassMock([UIViewController class]);
    id view = OCMClassMock([UIView class]);
    
    UIButton *button = [UNDTemplatesUI getButtonWithTitle:nil action:@selector(bla) target:target forView:view];

    expect(button).to.beNil();
}

- (void)testGetButtonWithTitleActionTargetForViewNilTitleNilAction
{
    id target = OCMClassMock([UIViewController class]);
    id view = OCMClassMock([UIView class]);
    
    UIButton *button = [UNDTemplatesUI getButtonWithTitle:@"bla" action:@selector(bla) target:target forView:view];
    
    expect(button).to.beNil();
}

//+ (UIButton *)getButtonWithTitle:(NSString *)title action:(SEL)selector target:(id)target forView:(UIView *)view
//{
//    if (!title || (title.length <=0)
//        || !selector || !target || !view)
//    {
//        return nil;
//    }
//    UIButton *button = [UIButton new];
//    [button setTitle:title forState:UIControlStateNormal];
//
//    button.backgroundColor = [UIColor colorWithRed:223/255.0f
//                                             green:223/255.0f
//                                              blue:223/255.0f
//                                             alpha:1];
//    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
//    button.layer.cornerRadius = 10;
//    button.alpha = 0.48;
//    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
//    button.layer.masksToBounds = NO;
//    button.layer.shadowColor = [UIColor blackColor].CGColor;
//    button.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    button.layer.shadowOpacity = 0.5f;
//
//    [view addSubview: button];
//    return button;
//}


#pragma mark - + (UILabel *)getLabel:(NSString *)text forView:(UIView *)view

- (void)testGetLabelForViewNilParameters
{
    UILabel *label = [UNDTemplatesUI getLabel:nil forView:nil];
    
    expect(label).to.beNil();
}

- (void)testGetLabelForViewEmptyText
{
    id view = OCMClassMock([UIView class]);
    
    UILabel *label = [UNDTemplatesUI getLabel:@"" forView:view];
    
    expect(label).to.beNil();
}

- (void)testGetLabelForViewNormal
{
    id view = OCMClassMock([UIView class]);
    
    UILabel *label = [UNDTemplatesUI getLabel:@"qweqw" forView:view];
    
    expect(label).toNot.beNil();
}

@end
