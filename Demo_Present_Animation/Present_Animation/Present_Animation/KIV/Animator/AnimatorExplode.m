//
//  AnimatorExplode.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorExplode.h"

@implementation AnimatorExplode

/**
 转场 呼入动画
 
 @param transitionContext 转场上下文
 */
- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [self explodeAnimate:transitionContext];
}


- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    [self explodeAnimate:transitionContext];
}

- (void)explodeAnimate:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    
    // Add the toView to the container
    UIView* containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    [containerView sendSubviewToBack:toView];
    
    CGSize size = toView.frame.size;
    
    NSMutableArray *snapshots = [NSMutableArray new];
    
    CGFloat xFactor = 10.0f;
    CGFloat yFactor = xFactor * size.height / size.width;
    
    // snapshot the from view, this makes subsequent snaphots more performant
    UIView *fromViewSnapshot = [fromView snapshotViewAfterScreenUpdates:NO];
    
    // create a snapshot for each of the exploding pieces
    for (CGFloat x=0; x < size.width; x+= size.width / xFactor) {
        for (CGFloat y=0; y < size.height; y+= size.height / yFactor) {
            CGRect snapshotRegion = CGRectMake(x, y, size.width / xFactor, size.height / yFactor);
            UIView *snapshot = [fromViewSnapshot resizableSnapshotViewFromRect:snapshotRegion  afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
            snapshot.frame = snapshotRegion;
            [containerView addSubview:snapshot];
            [snapshots addObject:snapshot];
        }
    }
    
    [containerView sendSubviewToBack:fromView];
    
    // animate
    NSTimeInterval duration = [self animateDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        for (UIView *view in snapshots) {
            CGFloat xOffset = [self randomFloatBetween:-100.0 and:100.0];
            CGFloat yOffset = [self randomFloatBetween:-100.0 and:100.0];
            view.frame = CGRectOffset(view.frame, xOffset, yOffset);
            view.alpha = 0.0;
            view.transform = CGAffineTransformScale(CGAffineTransformMakeRotation([self randomFloatBetween:-10.0 and:10.0]), 0.01, 0.01);
        }
    } completion:^(BOOL finished) {
        for (UIView *view in snapshots) {
            [view removeFromSuperview];
        }
        toView.transform = CGAffineTransformIdentity;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}
- (NSTimeInterval)animateDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.5;
}

@end
