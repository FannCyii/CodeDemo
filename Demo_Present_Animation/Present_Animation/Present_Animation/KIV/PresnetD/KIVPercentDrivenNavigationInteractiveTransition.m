//
//  KIVPercentDrivenNavigationInteractiveTransition.m
//  Present_Animation
//
//  Created by kivan on 18/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVPercentDrivenNavigationInteractiveTransition.h"

@interface KIVPercentDrivenNavigationInteractiveTransition ()
@property(nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property(nonatomic, strong) UINavigationController *toVc;
@property(nonatomic, strong) UIViewController *fromVc;
@end

@implementation KIVPercentDrivenNavigationInteractiveTransition
- (instancetype)initWithPresentViewController:(UINavigationController *)toVc fromVc:(UIViewController *)fromVc
{
    if ([self init]) {
        self.toVc = toVc;
        self.fromVc = fromVc;
        self.presentInter = YES;
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        if (self.fromVc) {
            [self.fromVc.view addGestureRecognizer:self.panGesture];
        }else{
            [self.toVc.view addGestureRecognizer:self.panGesture];
        }
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:gesture.view];
    NSLog(@"point:%f-%f",point.x,point.y);
    //CGPoint veloc = [gesture velocityInView:gesture.view];
    CGFloat width = self.toVc.view.frame.size.width;
    CGFloat height = self.toVc.view.frame.size.height;
    CGFloat presentation = 0;
    
    switch (self.direction) {
        case KIVTransitionDirectionUp:
            presentation = -point.y/height;
            break;
        case KIVTransitionDirectionDown:
            presentation = point.y/height;
            break;
        case KIVTransitionDirectionLeft:
            presentation = -point.x/width;
            break;
        case KIVTransitionDirectionRight:
            presentation = point.x/width;
            break;
        default:
            //默认向右滑动
            presentation = self.presentInter?point.x/width:-point.x/width;
            break;
    }
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //这里做push 和 pop操作
        
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:presentation];
    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled || gesture.state == UIGestureRecognizerStateFailed){
        if (presentation > 0.5) {
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
        self.interactive = NO;
    }
}

@end
