//
//  AnimatorBubble.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "AnimatorBubble.h"

@interface AnimatorBubble ()
@property (nonatomic, strong) UIView *bubbleView;
@end

@implementation AnimatorBubble

- (void)animateInTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    self.bubbleView = [[UIView alloc] initWithFrame:CGRectMake(screenFrame.size.width/2, screenFrame.size.height, 50, 50)];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.width/2;
    self.bubbleView.backgroundColor = [UIColor redColor];
    self.bubbleView.transform = CGAffineTransformMake(0.1, 0, 0, 0.1, 0, 0);
    [transitionContext.containerView addSubview:self.bubbleView];
    CGRect frame = toView.frame;
    UIColor *originColor = toView.backgroundColor;
    toView.backgroundColor = [UIColor redColor];
    toView.frame = CGRectMake(0, screenFrame.size.height, 1, 1);
    toView.alpha = 0;
    [transitionContext.containerView addSubview:toView];
    
    [UIView animateWithDuration:[self animateDuration:transitionContext] animations:^{
        self.bubbleView.transform = CGAffineTransformMake(100, 0, 0, 100, 0, 0);
        toView.frame = frame;
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        toView.backgroundColor = originColor;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        self.bubbleView.hidden = YES;
    }];
}

- (void)animateOutTransitioning:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:toView];
    self.bubbleView = [[UIView alloc] initWithFrame:CGRectMake(164, 492, 50, 50)];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.width/2;
    self.bubbleView.backgroundColor = [UIColor redColor];
    self.bubbleView.transform = CGAffineTransformMake(100, 0, 0, 100, 0, 0);
    [transitionContext.containerView addSubview:self.bubbleView];
    [transitionContext.containerView bringSubviewToFront:fromView];
    fromView.alpha = 1;
    [UIView animateWithDuration:0.5  animations:^{
        self.bubbleView.transform = CGAffineTransformMake(0.1, 0, 0, 0.1, 0, 0);
        //fromView.transform = CGAffineTransformIdentity;
        fromView.alpha = 0;
        fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        self.bubbleView.hidden = YES;
    }];
}

- (NSTimeInterval)animateDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1.2;
}
@end
