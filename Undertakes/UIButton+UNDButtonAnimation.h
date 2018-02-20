//
//  UIButton+UNDButtonAnimation.h
//  Undertakes
//
//  Created by Павел Пичкуров on 18.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (UNDButtonAnimation) <CAAnimationDelegate>

- (void)und_startRefreshAnimation;

- (void)und_startFailAnimation;

@end
