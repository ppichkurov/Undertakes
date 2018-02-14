//
//  UNDTemplatesUI.m
//  Undertakes
//
//  Created by Павел Пичкуров on 14.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDTemplatesUI.h"

@implementation UNDTemplatesUI

+ (UIButton *)getButtonWithTitle:(NSString *)title action:(SEL)selector target:(id)target toView:(UIView *)view
{
    UIButton *button = [UIButton new];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor colorWithRed:223/255.0f
                                             green:223/255.0f
                                              blue:223/255.0f
                                             alpha:1];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 10;
    button.alpha = 0.48;
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = NO;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    button.layer.shadowOpacity = 0.5f;
    
    [view addSubview: button];
    return button;
}

@end
