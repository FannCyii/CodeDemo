//
//  TabBarControllerTransitioner.m
//  Present_Animation
//
//  Created by kivan on 13/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "TabBarControllerTransitioner.h"
#import "Animator.h"

@implementation TabBarControllerTransitioner

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    Animator *animator = [[Animator alloc] init];
    NSInteger fromSelected = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toSelected = [tabBarController.viewControllers indexOfObject:toVC];
    if (fromSelected > toSelected) {
        animator.transitionType = TransitionPushRightType;
    }else{
        animator.transitionType = TransitionPushLeftType;
    }
    return animator;
}

@end
