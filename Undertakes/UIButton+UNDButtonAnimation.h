//
//  UIButton+UNDButtonAnimation.h
//  Undertakes
//
//  Created by Павел Пичкуров on 18.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (UNDButtonAnimation) <CAAnimationDelegate>

/**
 * <p>Стартует анимацию обновления на кнопке</p>
 */
- (void)und_startRefreshAnimation;

/**
 * <p>Стартует анимацию Ошибки на кнопке</p>
 */
- (void)und_startFailAnimation;

@end
