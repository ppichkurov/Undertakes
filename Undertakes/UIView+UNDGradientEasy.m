//
//  UIView+UNDGradientEasy.m
//  Undertakes
//
//  Created by Павел Пичкуров on 16.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import "UIView+UNDGradientEasy.h"


@implementation UIView (UNDGradientEasy)

- (void)und_gradientFrom:(UIColor *)colorBegin to:(UIColor *)colorEnd
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = @[colorBegin,colorEnd];
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
