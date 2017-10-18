//
//  KIVPercentDrivenInteractiveTransition.h
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVAnimateTransitioning.h"


@interface KIVPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition

/**
 当前是否在交互中
 */
@property (nonatomic, assign, getter=isIteractive)BOOL interactive;
/**
 交互方向
 */
@property (nonatomic, assign)KIVTransitionDirection direction;

/**
 呼入还是呼出，默认呼出交互,默认呼出
 */
@property (nonatomic, assign, getter=isPresentInteractive)BOOL presentInter;

/**
 初始化方法

 @param vc 当前操作的视图控制器，如果是呼入，则为当前vc，如果是呼入则为目标vc
 @return 实例
 */
- (instancetype)initWithPresentViewController:(UIViewController *)vc;

- (instancetype)initWithPresentViewController:(UIViewController *)vc fromVc:(UIViewController *)fromVc;

@end
