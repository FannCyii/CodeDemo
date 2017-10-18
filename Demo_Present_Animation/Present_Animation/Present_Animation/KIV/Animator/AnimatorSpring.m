//
//  AnimatorSpring.m
//  Present_Animation
//  弹簧动画
//  Created by kivan on 15/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorSpring.h"

@implementation AnimatorSpring
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self animateDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionFlipFromBottom
                     animations:^{
                         toVC.view.frame = finalFrame;
                     } completion:^(BOOL finished) {
                         // 5. Tell context that we completed.
                         //[screenSnapShotView removeFromSuperview];
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
    [UIView animateWithDuration:0.4 animations:^{
        fromView.frame = CGRectMake(orignFrame.origin.x, orignFrame.origin.y + orignFrame.size.height, orignFrame.size.width, orignFrame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.8;
}
@end
