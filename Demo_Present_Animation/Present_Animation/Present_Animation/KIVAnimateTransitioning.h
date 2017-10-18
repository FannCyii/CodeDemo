//
//  KIVAnimateTransitioning.h
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, KIVTransitionDirection) {
    KIVTransitionDirectionNone, //默认像右
    KIVTransitionDirectionUp,
    KIVTransitionDirectionDown,
    KIVTransitionDirectionLeft,
    KIVTransitionDirectionRight,
};


/**
 定义的动画接口
 */
@protocol KIVAnimateTransitioning <NSObject>

/*=============
 注意：直接使用
 UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
 UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
 UIView *toView = toVC.view;
 UIView *fromView = fromVC.view;
 有时候会出现呼出是黑屏的现象，需要使用如下方式来解决
 UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];//toVC.view;
 UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];// fromVC.view;
 =============*/

/**
 转场 呼入动画

 @param transitionContext 转场上下文
 */
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext;

/**
 转场 呼出动画

 @param transitionContext 转场上下文
 */
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext;

/**
 自定义动画时间，默认0.4秒

 @param transitionContext 转场上下文
 @return 动画时间
 */
@optional
- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext;

/**
 是否开启交互转场

 @return 是否
 */
+ (BOOL)animateSupportTransitioning;

/**
 交互的方向

 @return 交互的方向
 */
+ (KIVTransitionDirection)animateTransitioningDirection;


@end
