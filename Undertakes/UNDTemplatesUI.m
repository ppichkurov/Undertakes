//
//  UNDTemplatesUI.m
//  Undertakes
//
//  Created by Павел Пичкуров on 14.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UNDTemplatesUI.h"

@implementation UNDTemplatesUI

+ (UIColor *)getMainBackgroundColor
{
    return UIColor.lightGrayColor;
}

+ (UIColor *)colorForImportance:(NSUInteger)importance
{
    switch (importance) {
        case 1:
            return UIColor.darkGrayColor;
            break;
        case 2:
            return [UIColor colorWithRed:0
                                   green:153/255.0f
                                    blue:153/255.0f
                                   alpha:1];
            break;
        case 3:
            return UIColor.brownColor;
            break;
        case 4:
            return UIColor.purpleColor;
            break;
        case 5:
            return UIColor.orangeColor;
            break;
        default:
            return UIColor.greenColor;
            break;
    }
}


+ (UIButton *)getButtonWithTitle:(NSString *)title
                          action:(SEL)selector
                          target:(id)target
                         forView:(UIView *)view
{
    if (!title || (title.length <= 0)
        || !selector || !target || !view)
    {
        return nil;
    }
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

+ (UILabel *)getLabel:(NSString *)text forView:(UIView *)view
{
    if (!text || (text.length <= 0) || !view)
    {
        return nil;
    }
    UILabel *label = [UILabel new];
    label.text = text;
    label.textColor = UIColor.blackColor;
    [view addSubview: label];
    return label;
}
@end
