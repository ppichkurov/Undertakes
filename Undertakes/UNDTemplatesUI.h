//
//  UNDTemplatesUI.h
//  Undertakes
//
//  Created by Павел Пичкуров on 14.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UNDTemplatesUI : NSObject

+ (UIColor *)getMainBackgroundColor;

+ (UIColor *)colorForImportance:(NSUInteger)importance;

+ (UIButton *)getButtonWithTitle:(NSString *)title
                          action:(SEL)selector
                          target:(id)target
                          forView:(UIView *)view;

+ (UILabel *)getLabel:(NSString *)text forView:(UIView *)view;


@end
