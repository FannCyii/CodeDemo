//
//  Animator.m
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "Animator.h"

@interface Animator ()
//@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIView *bubbleView;
@end

@implementation Animator


- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.transitionType == TransitionPresentType) {
        [self presentAnimation:transitionContext];
    }else if(self.transitionType == TransitionDissmissType)
    {
        [self dismmisAnimation:transitionContext];
    }else if(self.transitionType == TransitionUpType)
    {
        [self upwardAnimation:transitionContext];
    }else if(self.transitionType == TransitionDownType)
    {
        [self downwardAnimation:transitionContext];
    }
    
    switch (self.transitionType) {
        case TransitionPushLeftType:
            [self pushLeftAnimation:transitionContext];
            break;
           case TransitionPopLeftType:
            [self popLeftAnimation:transitionContext];
            break;
        case TransitionPushRightType:
            [self pushRightAnimation:transitionContext];
            break;
        case TransitionPopRightType:
            [self popRightAnimation:transitionContext];
            break;
        case TransitionBubbleOut:
            [self bubbleOutAnimation:transitionContext];
            break;
        case TransitionBubbleIn:
            [self bubbleInAnimation:transitionContext];
            break;
        default:
            break;
    }

}

- (void)presentAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [containView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(fromFrame.origin.x+fromFrame.size.width, fromFrame.origin.y, fromFrame.size.width*7/8, toFrame.size.height);
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = CGRectMake(fromFrame.origin.x+fromFrame.size.width - toVC.view.frame.size.width, fromFrame.origin.y, fromFrame.size.width*7/8, toFrame.size.height);
        fromVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
- (void)dismmisAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];

    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    fromVC.view.frame = CGRectMake(toFrame.size.width/7, 0, toFrame.size.width, toFrame.size.height);
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = CGRectMake(toFrame.size.width, toFrame.origin.y, toFrame.size.width, toFrame.size.height);
        //toVC.view.frame = CGRectMake(0, 0, toFrame.size.width, toFrame.size.height);
    } completion:^(BOOL finished) {
        //[fromVC.view removeFromSuperview]; //#error : 这里不能手动移除fromview，而是有系统自动帮你处理，否则在取消动画时（cancelInteractiveTransition），fromView会消失，而transitionView不会消失。
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


- (void)pushLeftAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [containView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(fromFrame.origin.x+fromFrame.size.width, fromFrame.origin.y, fromFrame.size.width*7/8, toFrame.size.height);
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = fromFrame;
        fromVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
- (void)popLeftAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;

    UIView *containView = [transitionContext containerView];
    //在做navigation转场时，一定要将toView添加到containView上,否则做返回转场的时候，会出现视图为空的情况
    [containView addSubview:toVC.view];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [fromVC.view.superview bringSubviewToFront:fromVC.view];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = CGRectMake(toFrame.size.width, toFrame.origin.y, toFrame.size.width, toFrame.size.height);
        toVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)pushRightAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [containView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(fromFrame.origin.x-fromFrame.size.width, fromFrame.origin.y, fromFrame.size.width*7/8, toFrame.size.height);
    [UIView animateWithDuration:duration animations:^{
        toVC.view.frame = fromFrame;
        fromVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
- (void)popRightAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    //这里的presentView为空，因为设置了custom后，containView不在拥有fromView的控制器
    //UIView * presentView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIView *containView = [transitionContext containerView];
    containView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    //一定要将toView添加到containView上,否则做返回转场的时候，会出现视图为空的情况
    [containView addSubview:toVC.view];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    //toVC.view.frame = fromFrame;
    [fromVC.view.superview bringSubviewToFront:fromVC.view];
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.frame = CGRectMake(-toFrame.size.width, toFrame.origin.y, toFrame.size.width, toFrame.size.height);
        toVC.view.frame = fromFrame;
    } completion:^(BOOL finished) {
        //[fromVC.view removeFromSuperview]; //#error : 这里不能手动移除fromview，而是有系统自动帮你处理，否则在取消动画时（cancelInteractiveTransition），fromView会消失，而transitionView不会消失。
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}


- (void)upwardAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.frame = CGRectMake(toViewController.view.frame.origin.x, toViewController.view.frame.origin.y + toViewController.view.frame.size.height, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toViewController.view.frame = fromViewController.view.frame;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

- (void)downwardAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
   
    [[transitionContext containerView] addSubview:toView];
    toView.frame = fromView.frame;
     [fromView.superview bringSubviewToFront:fromView];

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(toView.frame.origin.x, toView.frame.origin.y + toView.frame.size.height, toView.frame.size.width, toView.frame.size.height);
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)bubbleOutAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
   // UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    self.bubbleView = [[UIView alloc] initWithFrame:CGRectMake(164, 492, 50, 50)];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.width/2;
    self.bubbleView.backgroundColor = [UIColor redColor];
    self.bubbleView.transform = CGAffineTransformMake(0.1, 0, 0, 0.1, 0, 0);
    [transitionContext.containerView addSubview:self.bubbleView];
    CGRect frame = toView.frame;
   // toView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    toView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 1, 1);
    toView.alpha = 0;
    [transitionContext.containerView addSubview:toView];
    
    [UIView animateWithDuration:1 animations:^{
        //self.bubbleView.alpha = 1;
        self.bubbleView.transform = CGAffineTransformMake(100, 0, 0, 100, 0, 0);
        //toView.transform = CGAffineTransformIdentity;
        toView.frame = frame;
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        self.bubbleView.hidden = YES;
    }];
}

- (void)bubbleInAnimation:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    self.bubbleView = [[UIView alloc] initWithFrame:CGRectMake(164, 492, 50, 50)];
    self.bubbleView.layer.cornerRadius = self.bubbleView.frame.size.width/2;
    self.bubbleView.backgroundColor = [UIColor redColor];
    self.bubbleView.transform = CGAffineTransformMake(80, 0, 0, 80, 0, 0);
    [transitionContext.containerView addSubview:self.bubbleView];
    fromView.alpha = 1;
    [UIView animateWithDuration:0.4 animations:^{
        self.bubbleView.transform = CGAffineTransformMake(0.1, 0, 0, 0.1, 0, 0);
        fromView.transform = CGAffineTransformIdentity;
        fromView.alpha = 0;
        fromView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        self.bubbleView.hidden = YES;
    }];
}


@end
