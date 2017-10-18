//
//  AnimatorPan.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorPan.h"

@implementation AnimatorPan
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [self panAnimator:transitionContext reverse:YES];
}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [self panAnimator:transitionContext reverse:NO];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)panAnimator:(id<UIViewControllerContextTransitioning>)transitionContext reverse:(BOOL)reverse{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];//toVC.view;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];// fromVC.view;

    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    toView.frame = CGRectMake(reverse ? -160 : 320, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    
    reverse ? [containerView sendSubviewToBack:toView] : [containerView bringSubviewToFront:toView];
    
    // animate
    NSTimeInterval duration = [self animateDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromView.frame = CGRectMake(!reverse ? -160 : 320, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
            fromView.frame = CGRectMake(0, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
        } else {
            // reset from- view to its original state
            [fromView removeFromSuperview];
            fromView.frame = CGRectMake(!reverse ? -160 : 320, fromView.frame.origin.y, fromView.frame.size.width, fromView.frame.size.height);
            toView.frame = CGRectMake(0, toView.frame.origin.y, toView.frame.size.width, toView.frame.size.height);
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}

@end
