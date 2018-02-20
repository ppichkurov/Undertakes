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

/**
 * <p>Возвращает основной цвет бекграунда приложения</p>
 * @return цвет бекграунда
 */
+ (UIColor *)getMainBackgroundColor;

/**
 * <p>Возвращает цвет в зависимости от важности обещания</p>
 * @param importance - важность обещания ( от 1 до 5 )
 * @return цвет в соответствии с переданным параметром
 */
+ (UIColor *)colorForImportance:(NSUInteger)importance;

/**
 * <p>Возвращает экземпляр кнопки стилизованной для приложения</p>
 * @param title - заголовок кнопки
 * @param selector - экшен кнопки
 * @param target - кто выполнит экшн
 * @param view - куда добавить кнопку
 * @return экземпляр кнопки
 */
+ (UIButton *)getButtonWithTitle:(NSString *)title
                          action:(SEL)selector
                          target:(id)target
                          forView:(UIView *)view;

/**
 * <p>Возвращает экземпляр лейбла стилизованной для приложения</p>
 * @param text - текст лейбла
 * @param view - куда добавить лейбл
 * @return экземпляр лейбла
 */
+ (UILabel *)getLabel:(NSString *)text forView:(UIView *)view;

@end
