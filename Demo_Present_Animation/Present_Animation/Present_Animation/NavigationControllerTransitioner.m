//
//  NavigationControllerTransitioner.m
//  Present_Animation
//
//  Created by kivan on 05/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "NavigationControllerTransitioner.h"
#import "Animator.h"

@implementation NavigationControllerTransitioner

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    switch(self.animationType){
        case NavigationControllerAnimationLeft:
            return [self navigationTransitionLeft:operation];
            break;
        case NavigationControllerAnimationRight:
            return [self navigationTransitionRight:operation];
            break;
        case NavigationControllerAnimationUp:
            return [self navigationTransitionUp:operation];
            break;
        case NavigationControllerAnimationDown:
            break;
        default:
            break;
    
    }
    return  nil;
}


- (Animator *)navigationTransitionLeft:(UINavigationControllerOperation)operation{
    if (operation == UINavigationControllerOperationPush)
    {
        Animator *animator = [Animator new];
        animator.transitionType = TransitionPushLeftType;
        return animator;
    }else if(operation == UINavigationControllerOperationPop)
    {
        Animator *animator = [Animator new];
        animator.transitionType = TransitionPopLeftType;
        return animator;
    }
    
    return nil;
}

- (Animator *)navigationTransitionRight:(UINavigationControllerOperation)operation{
    if (operation == UINavigationControllerOperationPush)
    {
        Animator *animator = [Animator new];
        animator.transitionType = TransitionPushRightType;
        return animator;
    }else if(operation == UINavigationControllerOperationPop)
    {
        Animator *animator = [Animator new];
        animator.transitionType = TransitionPopRightType;
        return animator;
    }
    
    return nil;
}

- (Animator *)navigationTransitionUp:(UINavigationControllerOperation)operation{
    if (operation == UINavigationControllerOperationPush)
    {
        Animator *animator = [Animator new];
        animator.transitionType = TransitionUpType;
        return animator;
    }else if(operation == UINavigationControllerOperationPop)
    {
        Animator *animator = [Animator new];
        animator.transitionType = TransitionDownType;
        return animator;
    }
    
    return nil;
}


@end
