//
//  Transitioner.m
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "Transitioner.h"
#import "Animator.h" //#1
#import "CustomPresentationControllerRight.h"

@interface Transitioner ()
@property (nonatomic, strong) Animator *animator;

@end

@implementation Transitioner

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    Animator *presentAnimation = [[Animator alloc] init];
    if (self.transitionerType == TransitionerBubble) {
        presentAnimation.transitionType = TransitionBubbleOut;
    }else{
        presentAnimation.transitionType = TransitionPresentType;
    }
    
    source.modalPresentationStyle = UIModalPresentationCustom;
    return presentAnimation;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    Animator *dissmissAnimation = [[Animator alloc] init];
    
    if (self.transitionerType == TransitionerBubble) {
        dissmissAnimation.transitionType = TransitionBubbleIn;
    }else{
        dissmissAnimation.transitionType = TransitionDissmissType;
    }
    return dissmissAnimation;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return  self.interactiveTransor.interacting ? self.interactiveTransor:nil;
}

///*
// precentController 和 animator的动画可以同时执行
// */
////使用precentController时 调用的代理方法
//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
//{
//
//    return  [[CustomPresentationControllerRight alloc] initWithPresentedViewController:presented presentingViewController:presenting];
//}


@end
