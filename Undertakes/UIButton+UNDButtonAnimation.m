//
//  UIButton+UNDButtonAnimation.m
//  Undertakes
//
//  Created by Павел Пичкуров on 18.02.2018.
//  Copyright © 2018 Павел Пичкуров. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton+UNDButtonAnimation.h"

static NSString *groupAnimationKey = @"groupAnimationKey";


CALayer *UNDCircleLayer;

static const CGFloat UNDForwardAndBackwardDuration = 1.0f;
static const CGFloat UNDCircleAnimationDuration = 1.0f;
static const NSUInteger UNDCircleAnimationRepeatCount = 4;


@implementation UIButton (UNDButtonAnimation)

- (void)und_startRefreshAnimation
{
    [self setTitleColor:UIColor.clearColor forState:UIControlStateNormal];
    self.userInteractionEnabled = NO;
    [self firstAnimationGrooup];
}

- (void)firstAnimationGrooup
{
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = 1;
    animationGroup.duration = UNDForwardAndBackwardDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    
    CABasicAnimation *sizeDecreaseAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    sizeDecreaseAnimation.duration = 0.3;
    sizeDecreaseAnimation.fromValue = @(self.bounds);
    sizeDecreaseAnimation.toValue = @(CGRectMake(0, 0, 44, 44));
    sizeDecreaseAnimation.fillMode = kCAFillModeForwards;
    sizeDecreaseAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    shadowAnimation.duration = 0.2;
    shadowAnimation.fromValue = @(self.layer.shadowOffset);
    shadowAnimation.toValue = @(CGSizeMake(0.0f, 0.0f));
    shadowAnimation.fillMode = kCAFillModeForwards;
    shadowAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimation.duration = 0.45;
    cornerRadiusAnimation.fromValue = @(10.0);
    cornerRadiusAnimation.toValue = @(22);
    cornerRadiusAnimation.fillMode = kCAFillModeForwards;
    cornerRadiusAnimation.removedOnCompletion = NO;
    
    animationGroup.animations = @[sizeDecreaseAnimation, cornerRadiusAnimation, shadowAnimation];
    [animationGroup setValue:@"animationGroupFirst" forKey:@"id"];
    
    [self.layer addAnimation:animationGroup forKey:groupAnimationKey];
}

- (void)secondAnimationGroup
{
    CGSize size = CGSizeMake(44.0f, 44.0f);
    
    CGFloat circleSize = size.width / 5;
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.7f :-0.13f :0.22f :0.86f];
    
    // Scale animation
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    scaleAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    scaleAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.6f, 0.6f, 1.0f)],
                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)]];
    scaleAnimation.duration = UNDCircleAnimationDuration;
    scaleAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Rotate animation
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotateAnimation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    rotateAnimation.values = @[@0, @-M_PI, @(-2 * M_PI)];
    rotateAnimation.duration = UNDCircleAnimationDuration;
    rotateAnimation.timingFunctions = @[timingFunction, timingFunction];
    
    // Animation
    CAAnimationGroup *animation = [CAAnimationGroup animation];
    
    animation.animations = @[scaleAnimation, rotateAnimation];
    animation.duration = UNDCircleAnimationDuration;
    animation.repeatCount = UNDCircleAnimationRepeatCount;
    animation.removedOnCompletion = YES;
    animation.delegate = self;
    [animation setValue:@"animationGroupSecond" forKey:@"id"];

    // Draw circles
    
    CALayer *leftCircle = [CALayer layer];
    
    leftCircle.backgroundColor = [UIColor colorWithRed:1 green:90.0f/255.0f blue:96.0f/255.0f alpha:1].CGColor;
    leftCircle.opacity = 0.8f;
    leftCircle.cornerRadius = circleSize / 2;
    leftCircle.frame = CGRectMake(0, (size.height - circleSize) / 2, circleSize, circleSize);
    
    CALayer *rightCircle = [CALayer layer];
    
    rightCircle.backgroundColor = [UIColor colorWithRed:1 green:90.0f/255.0f blue:96.0f/255.0f alpha:1].CGColor;
    rightCircle.opacity = 0.8f;
    rightCircle.cornerRadius = circleSize / 2;
    rightCircle.frame = CGRectMake(size.width - circleSize, (size.height - circleSize) / 2, circleSize, circleSize);
    
    CALayer *centerCircle = [CALayer layer];
    
    centerCircle.backgroundColor = [UIColor colorWithRed:1 green:90.0f/255.0f blue:96.0f/255.0f alpha:1].CGColor;
    centerCircle.cornerRadius = circleSize / 2;
    centerCircle.frame = CGRectMake((size.width - circleSize) / 2, (size.height - circleSize) / 2, circleSize, circleSize);
    
    UNDCircleLayer = [CALayer layer];
    
    UNDCircleLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [UNDCircleLayer addSublayer:leftCircle];
    [UNDCircleLayer addSublayer:rightCircle];
    [UNDCircleLayer addSublayer:centerCircle];
    [UNDCircleLayer addAnimation:animation forKey:@"animationGroupSecond"];
    [self.layer addSublayer:UNDCircleLayer];
}

- (void)thirdAnimationGroup
{    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.repeatCount = 1;
    animationGroup.duration = UNDForwardAndBackwardDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.autoreverses = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    
    CABasicAnimation *sizeIncreaseAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    sizeIncreaseAnimation.duration = 0.3;
    sizeIncreaseAnimation.fromValue = @(CGRectMake(0, 0, 44, 44));
    sizeIncreaseAnimation.toValue = @(self.bounds);
    sizeIncreaseAnimation.fillMode = kCAFillModeForwards;
    sizeIncreaseAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    shadowAnimation.duration = 0.2;
    shadowAnimation.fromValue = @(CGSizeMake(0.0f, 0.0f));
    shadowAnimation.toValue = @(self.layer.shadowOffset);
    shadowAnimation.fillMode = kCAFillModeForwards;
    shadowAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *cornerRadiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    cornerRadiusAnimation.duration = 0.45;
    cornerRadiusAnimation.fromValue = @(22.0f);
    cornerRadiusAnimation.toValue = @(10.0f);
    cornerRadiusAnimation.fillMode = kCAFillModeForwards;
    cornerRadiusAnimation.removedOnCompletion = NO;
    
    animationGroup.animations = @[sizeIncreaseAnimation, cornerRadiusAnimation, shadowAnimation];
    [animationGroup setValue:@"animationGroupThird" forKey:@"id"];
    
    [self.layer addAnimation:animationGroup forKey:groupAnimationKey];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if([[anim valueForKey:@"id"] isEqual:@"animationGroupFirst"]) {
        NSLog(@"firstAnim was stopped");
        [self secondAnimationGroup];
        return;
    }
    if([[anim valueForKey:@"id"] isEqual:@"animationGroupSecond"]) {
        NSLog(@"secondAnim was stopped");
        [UNDCircleLayer removeAllAnimations];
        [UNDCircleLayer removeFromSuperlayer];
        [self thirdAnimationGroup];
        return;
    }
    
    [self.layer removeAllAnimations];
    [self setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
}

- (void)und_startFailAnimation
{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.3;
    } completion:^(BOOL finished) {
        self.alpha = 0.48;
    }];
}

@end
