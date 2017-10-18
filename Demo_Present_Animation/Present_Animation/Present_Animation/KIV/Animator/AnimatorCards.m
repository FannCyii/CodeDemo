//
//  AnimatorCards.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorCards.h"

@implementation AnimatorCards
/*
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{

}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{

}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}
*/

- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    UIView* containerView = [transitionContext containerView];
    
    // positions the to- view off the bottom of the sceen
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    CGRect offScreenFrame = frame;
    offScreenFrame.origin.y = offScreenFrame.size.height;
    toView.frame = offScreenFrame;
    
    [containerView insertSubview:toView aboveSubview:fromView];
    
    CATransform3D t1 = [self firstTransform];
    CATransform3D t2 = [self secondTransformWithView:fromView];
    
    [UIView animateKeyframesWithDuration:[self animateDuration:transitionContext] delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        // push the from- view to the back
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.4f animations:^{
            fromView.layer.transform = t1;
            fromView.alpha = 0.6;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2f relativeDuration:0.4f animations:^{
            fromView.layer.transform = t2;
        }];
        
        // slide the to- view upwards. In his original implementation Tope used a 'spring' animation, however
        // this does not work with keyframes, so we siulate it by overshooting the final location in
        // the first keyframe
        [UIView addKeyframeWithRelativeStartTime:0.6f relativeDuration:0.2f animations:^{
            toView.frame = CGRectOffset(toView.frame, 0.0, -30.0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.8f relativeDuration:0.2f animations:^{
            toView.frame = frame;
        }];
        
    } completion:^(BOOL finished) {
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    UIView* containerView = [transitionContext containerView];
    
    // positions the to- view behind the from- view
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    toView.frame = frame;
    CATransform3D scale = CATransform3DIdentity;
    toView.layer.transform = CATransform3DScale(scale, 0.6, 0.6, 1);
    toView.alpha = 0.6;
    
    [containerView insertSubview:toView belowSubview:fromView];
    
    CGRect frameOffScreen = frame;
    frameOffScreen.origin.y = frame.size.height;
    
    CATransform3D t1 = [self firstTransform];
    
    [UIView animateKeyframesWithDuration:[self animateDuration:transitionContext] delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        // push the from- view off the bottom of the screen
        [UIView addKeyframeWithRelativeStartTime:0.0f relativeDuration:0.5f animations:^{
            fromView.frame = frameOffScreen;
        }];
        
        // animate the to- view into place
        [UIView addKeyframeWithRelativeStartTime:0.35f relativeDuration:0.35f animations:^{
            toView.layer.transform = t1;
            toView.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.75f relativeDuration:0.25f animations:^{
            toView.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        if ([transitionContext transitionWasCancelled]) {
            toView.layer.transform = CATransform3DIdentity;
            toView.alpha = 1.0;
        }
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    return t1;
    
}

-(CATransform3D)secondTransformWithView:(UIView*)view{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    
    return t2;
}
@end
