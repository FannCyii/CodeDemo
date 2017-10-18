//
//  KIVTransitionor.h
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIVTransitionor : NSObject <UIViewControllerTransitioningDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate>
/**
 转场控制器 初始化方法

 @param toVc 转场视图控制器, UIViewController 对应 模态转场，需传入转场目标viewController
 @param animatorName 动画类目 对应类必须遵循 KIVAnimateTransitioning 代理
 @return 转场实例
 */
- (instancetype)initWith:(UIViewController *)toVc animatorClassName:(NSString *)animatorName;

/**
  转场控制器 初始化方法

 @param toVc 转场视图控制器, UIViewController 对应 模态转场，需传入转场目标viewController
 @param animatorName 动画类目 对应类必须遵循 KIVAnimateTransitioning 代理
 @param presentationClassName 使用的presentationController，用于进一步控制转场视图
 @return 转场实例
 */
- (instancetype)initWith:(UIViewController *)toVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName;

- (instancetype)initWith:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName;

//- (instancetype)initWithVc:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName;
//
//- (instancetype)initWithNavigation:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName;
//
//- (instancetype)initWithTabBar:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName;
//更换呼出VC
- (void)transitionWithVc:(UIViewController *)vc;


@end
