//
//  KIVPercentDrivenNavigationInteractiveTransition.h
//  Present_Animation
//
//  Created by kivan on 18/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVAnimateTransitioning.h"

@interface KIVPercentDrivenNavigationInteractiveTransition : UIPercentDrivenInteractiveTransition
- (instancetype)initWithPresentViewController:(UIViewController *)vc fromVc:(UIViewController *)fromVc;


/**
 当前是否在交互中
 */
@property (nonatomic, assign, getter=isIteractive)BOOL interactive;

/**
 呼入还是呼出，默认呼出交互,默认呼出
 */
@property (nonatomic, assign, getter=isPresentInteractive)BOOL presentInter;
/**
 交互方向
 */
@property (nonatomic, assign)KIVTransitionDirection direction;


@end
