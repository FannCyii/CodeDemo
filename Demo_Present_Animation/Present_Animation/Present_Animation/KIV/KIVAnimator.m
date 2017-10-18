//
//  KIVAnimator.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVAnimator.h"

@interface KIVAnimator()
@property (nonatomic, strong) id <KIVAnimateTransitioning> animateTransitioning;
@property (nonatomic, assign)KIVAnimatorType animatoryType;
@end

@implementation KIVAnimator

+ (instancetype)animatorWith:(NSString *)animatorClassName withType:(KIVAnimatorType)animatorType
{
    KIVAnimator *animator = [KIVAnimator new];
    if (animator) {
        animator.animateTransitioning = [NSClassFromString(animatorClassName) new];
        animator.animatoryType = animatorType;
    }
    return animator;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.animateTransitioning) {
        return [self.animateTransitioning animateDuration:transitionContext];
    }
    return 0.4;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (!self.animateTransitioning) {
        return;
    }
    if (self.animatoryType == KIVAnimatorIn){
        [self.animateTransitioning animateInTransitioning:transitionContext];
    }else if(self.animatoryType == KIVAnimatorOut){
        [self.animateTransitioning animateOutTransitioning:transitionContext];
    }
}

@end
