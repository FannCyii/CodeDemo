//
//  InteractiveTransitioner.m
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "InteractiveTransitioner.h"
#import "Animator.h"  //#1


@interface InteractiveTransitioner ()
@property (nonatomic, strong) UIPanGestureRecognizer * gesture;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) UIViewController *presentVc;
@end

@implementation InteractiveTransitioner


- (void)interactiveTransitionWith:(UIViewController *)vc fromVc:(UIViewController *)fromVc
{
    self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestionAction:)];
    self.vc = vc;
    self.presentVc = fromVc;
    [vc.view addGestureRecognizer:self.gesture];
}

- (void)gestionAction:(UIPanGestureRecognizer *)gesture
{
//    CGPoint vel = [gesture velocityInView:gesture.view];
    CGPoint point = [gesture translationInView:gesture.view];
    CGFloat percent = 0;
    
    percent = point.x /gesture.view.frame.size.width;
    NSLog(@"==:%f",percent);
//    if (vel.x > 0) {
//        percent = point.x /gesture. self.view.frame.size.width;
//        NSLog(@"==:%f",percent);
//    }
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        [self.vc dismissViewControllerAnimated:YES completion:nil];
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:percent];
    }else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled){
        if (percent > 0.5) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
        self.interacting = NO;
    }
}

@end
