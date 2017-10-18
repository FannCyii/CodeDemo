//
//  KIVPercentDrivenInteractiveTransition.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVPercentDrivenInteractiveTransition.h"
@interface KIVPercentDrivenInteractiveTransition ()
@property(nonatomic, strong) UIPanGestureRecognizer *panGesture;
@property(nonatomic, strong) UIViewController *presentedVc;
@property(nonatomic, strong) UIViewController *fromVc;
@end

@implementation KIVPercentDrivenInteractiveTransition

- (instancetype)initWithPresentViewController:(UIViewController *)vc
{
    return [self initWithPresentViewController:vc fromVc:nil];
}

- (instancetype)initWithPresentViewController:(UIViewController *)vc fromVc:(UIViewController *)fromVc
{
    if ([self init]) {
        self.presentedVc = vc;
        self.fromVc = fromVc;
        self.presentInter = YES;
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        if (self.fromVc) {
            [self.fromVc.view addGestureRecognizer:self.panGesture];
        }else{
            [self.presentedVc.view addGestureRecognizer:self.panGesture];
        }
    }
    return self;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gesture
{
    CGPoint point = [gesture translationInView:gesture.view];
    NSLog(@"point:%f-%f",point.x,point.y);
    //CGPoint veloc = [gesture velocityInView:gesture.view];
    CGFloat width = self.presentedVc.view.frame.size.width;
    CGFloat height = self.presentedVc.view.frame.size.height;
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
        self.interactive = YES;
        if (self.presentInter) {
            [self.presentedVc dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self.fromVc presentViewController:self.presentedVc animated:YES completion:nil];
        }
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
