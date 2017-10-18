//
//  AnimatorPushAndPop.m
//  Present_Animation
//
//  Created by kivan on 15/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorPushAndPop.h"
#define KWindowWidth [UIApplication sharedApplication].keyWindow.frame.size.width
#define KWindowHeight [UIApplication sharedApplication].keyWindow.frame.size.height

typedef NS_ENUM(NSUInteger,TransitionAnimType)
{
    TransitionAnimTypePush,
    TransitionAnimTypePop
};

@interface AnimatorPushAndPop ()<CAAnimationDelegate>
@property(nonatomic,strong) id<UIViewControllerContextTransitioning>transitionContext;
@property (nonatomic, assign) TransitionAnimType type;
@end

@implementation AnimatorPushAndPop
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    
    CATransition *transition = [CATransition animation];
    //transition.autoreverses = YES;    //回退动画（动画可逆，即循环）
    //transition.duration = 10.0f;
    //transition.repeatCount = MAXFLOAT;
    transition.delegate = self;
    transition.removedOnCompletion = NO;
    transition.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //    - 确定动画类型:
    transition.type = @"rippleEffect";
    
    //    - 确定子类型(方向等)
    transition.subtype = kCATransitionFromLeft;
    
    //    - 确定动画时间
    transition.duration = 1;
    
    //    - 添加动画
    [containerView.layer addAnimation:transition forKey:nil];
    
    self.transitionContext = transitionContext;
}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    //路径处理
    CGRect originRect = CGRectMake(KWindowWidth-50, KWindowHeight-50, 50, 50);
    UIBezierPath *maskStartPath = [UIBezierPath bezierPathWithOvalInRect:originRect];
    UIBezierPath *maskEndPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(originRect, -2000, -2000)];
    //创建一个CAShapeLayer来负责展示圆形遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.fromValue = (id)maskStartPath.CGPath;
    maskAnimation.toValue = (id)maskEndPath.CGPath;
    maskAnimation.duration = [self animateDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.fillMode = kCAFillModeForwards;
    maskAnimation.removedOnCompletion = NO;
    maskAnimation.delegate = self;
    [maskLayer addAnimation:maskAnimation forKey:@"Path"];
    
    self.transitionContext = transitionContext;
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

////不会执行这一步
//- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
//{
//    self.transitionContext = transitionContext;
//    switch (self.type)
//    {
//        case TransitionAnimTypePop:
//            [self animateOutTransitioning:transitionContext];
//            break;
//        case TransitionAnimTypePush:
//            [self animateInTransitioning:transitionContext];
//            break;
//        default:
//            break;
//    }
//
//}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //完成动画
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    //去除mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
