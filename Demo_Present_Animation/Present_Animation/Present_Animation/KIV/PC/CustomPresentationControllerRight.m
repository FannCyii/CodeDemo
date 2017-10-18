//
//  CustomPresentationControllerRight.m
//  Present_Animation
//
//  Created by kivan on 17/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "CustomPresentationControllerRight.h"

@interface CustomPresentationControllerRight ()
@property (nonatomic, strong)UIView *dimmingView;
@property (nonatomic, strong)UITapGestureRecognizer *tapGesture;
@end

@implementation CustomPresentationControllerRight

/**
 在转场过程中添加自定视图，并做额外的自定动画效果
 开始呼入（呈现）
 */
- (void)presentationTransitionWillBegin{
    CGRect frame = self.presentedView.frame;
    self.dimmingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height)];
    self.dimmingView.backgroundColor = [UIColor clearColor];//[UIColor colorWithWhite:0.5 alpha:0.5];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.dimmingView addGestureRecognizer:_tapGesture];
    
    [self.containerView addSubview:self.dimmingView];
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.presentingViewController.view.frame = CGRectInset(self.containerView.frame, -100, 0);
        self.presentedView.frame = CGRectMake(frame.size.width/5, frame.origin.y, frame.size.width, frame.size.height);
        self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {

    }];
    
//直接使用动画无法操作部分动画效果
//    [UIView animateWithDuration:0.5 animations:^{
//                self.presentingViewController.view.frame = CGRectInset(self.containerView.frame, -100, 0);
//        self.presentedView.frame = CGRectMake(frame.size.width/5, frame.origin.y, frame.size.width, frame.size.height);
//        self.dimmingView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
//    }];
}

/**
 在转场过程中添加自定视图，并做额外的自定动画效果
 当转场动画呼出后，UIKit会自动将自定义视图以及转场vc都释放掉
 如果是取消转场操作，则知会释放presentController中自定义的视图
 
 开始呼出（消失）
 */
- (void)dismissalTransitionWillBegin{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.presentingViewController.view.frame = CGRectInset(self.containerView.frame, 0, 0);
        self.dimmingView.alpha = 0.0;
    } completion:nil];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
