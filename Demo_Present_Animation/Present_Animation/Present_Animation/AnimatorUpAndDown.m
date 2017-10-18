//
//  AnimatorUpAndDown.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorUpAndDown.h"

@implementation AnimatorUpAndDown 
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectMake(toViewController.view.frame.origin.x, toViewController.view.frame.origin.y + toViewController.view.frame.size.height, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
    
    [UIView animateWithDuration:[self animateDuration:transitionContext] animations:^{
        toViewController.view.frame = fromViewController.view.frame;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [[transitionContext containerView] addSubview:toView];
    CGRect orignFrame = fromView.frame;
    toView.frame = orignFrame;
    [fromView.superview bringSubviewToFront:fromView];
    [UIView animateWithDuration:[self animateDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(orignFrame.origin.x, orignFrame.origin.y + orignFrame.size.height, orignFrame.size.width, orignFrame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

+ (BOOL)animateSupportTransitioning
{
    return YES;
}

+ (KIVTransitionDirection)animateTransitioningDirection
{
    return KIVTransitionDirectionDown;
}
@end
