//
//  AnimatorHalfRightIn.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorHalfRightIn.h"

@implementation AnimatorHalfRightIn
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    NSTimeInterval duration = [self animateDuration:transitionContext];
    [containView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(fromFrame.origin.x+fromFrame.size.width, fromFrame.origin.y, fromFrame.size.width*7/8, toFrame.size.height);
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = CGRectMake(fromFrame.origin.x+fromFrame.size.width - toVC.view.frame.size.width, fromFrame.origin.y, fromFrame.size.width*7/8, toFrame.size.height);
        fromVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containView = [transitionContext containerView];
    //containView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    NSTimeInterval duration = [self animateDuration:transitionContext];
    fromVC.view.frame = CGRectMake(toFrame.size.width/7, 0, toFrame.size.width, toFrame.size.height);
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = CGRectMake(toFrame.size.width, toFrame.origin.y, toFrame.size.width, toFrame.size.height);
        //toVC.view.frame = CGRectMake(0, 0, toFrame.size.width, toFrame.size.height);
    } completion:^(BOOL finished) {
        //[fromVC.view removeFromSuperview]; //#error : 这里不能手动移除fromview，而是有系统自动帮你处理，否则在取消动画时（cancelInteractiveTransition），fromView会消失，而transitionView不会消失。
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

+ (BOOL)animateSupportTransitioning{
    return YES;
}

@end
