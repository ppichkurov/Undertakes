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

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
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
    
    UIButton *button = [UNDTemplatesUI getButtonWithTitle:@"bla" action:nil target:target forView:view];
    
    expect(button).to.beNil();
}

- (void)testGetButtonWithTitleActionTargetForViewNilTitleNilTarget
{
    id view = OCMClassMock([UIView class]);
    
    UIButton *button = [UNDTemplatesUI getButtonWithTitle:@"bla" action:@selector(bla) target:nil forView:view];
    
    expect(button).to.beNil();
}

- (void)testGetButtonWithTitleActionTargetForViewNilTitleNilView
{
    id target = OCMClassMock([UIViewController class]);
    
    UIButton *button = [UNDTemplatesUI getButtonWithTitle:@"bla" action:@selector(bla) target:target forView:nil];
    
    expect(button).to.beNil();
}

- (void)testGetButtonWithTitleActionTargetForViewNormal
{
    id target = OCMClassMock([UIViewController class]);
    id view = OCMClassMock([UIView class]);

    UIButton *button = [UNDTemplatesUI getButtonWithTitle:@"bla" action:@selector(bla) target:target forView:view];
    
    expect(button).toNot.beNil();
}


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
