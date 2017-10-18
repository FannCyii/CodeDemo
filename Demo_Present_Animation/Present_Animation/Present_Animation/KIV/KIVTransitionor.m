//
//  KIVTransitionor.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "KIVTransitionor.h"
#import "KIVAnimator.h"
#import "KIVAnimateTransitioning.h"
#import "KIVPercentDrivenInteractiveTransition.h"
#import "CustomPresentationControllerRight.h"
#import "KIVPercentDrivenNavigationInteractiveTransition.h"

typedef NS_ENUM(NSInteger, KIVControllerType) {
    KIVViewController,
    KIVNavigationController,
    KIVTabBarViewController,
};

@interface KIVTransitionor ()
/**
 自定义实现的动画类名称，该类必须继承KIVAnimateTransitioning协议
 */
@property (nonatomic, strong) NSString *animatorClassName;

/**
 自定义Present动画类名称，该类必须继承UIPresentationController类
 */
@property (nonatomic, strong) NSString *presentationClassName;

@property (nonatomic, strong)KIVPercentDrivenInteractiveTransition *percentDrivenOut;
@property (nonatomic, strong)KIVPercentDrivenInteractiveTransition *percentDrivenIn;
@property (nonatomic, strong)UIViewController *toVc;
@property (nonatomic, strong)UIViewController *fromVc;
@property (nonatomic, assign)BOOL isPresent;

@property (nonatomic, assign)KIVControllerType transitionorType;
@end

@implementation KIVTransitionor

- (instancetype)initWith:(UIViewController *)toVc animatorClassName:(NSString *)animatorName
{
    return [self initWith:toVc animatorClassName:animatorName presentationController:nil];
}

- (instancetype)initWith:(UIViewController *)toVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName{
    return [self initWith:toVc fromVc:nil animatorClassName:animatorName presentationController:presentationClassName];
}

//- (instancetype)initWithVc:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName
//{
//    self.transitionorType = KIVViewController;
//    return [self initWith:toVc fromVc:fromVc animatorClassName:animatorName presentationController:presentationClassName];
//}
//
//- (instancetype)initWithNavigation:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName
//{
//    self.transitionorType = KIVNavigationController;
//    return [self initWith:toVc fromVc:fromVc animatorClassName:animatorName presentationController:presentationClassName];
//}
//
//- (instancetype)initWithTabBar:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName
//{
//    self.transitionorType = KIVTabBarViewController;
//    return [self initWith:toVc fromVc:fromVc animatorClassName:animatorName presentationController:presentationClassName];
//}


- (instancetype)initWith:(UIViewController *)toVc fromVc:(UIViewController *)fromVc animatorClassName:(NSString *)animatorName presentationController:(NSString *)presentationClassName{
    if([self init]){
        if (!NSClassFromString(animatorName)) {
            NSLog(@"动画类名不存在");
            return nil;
        }
        self.toVc = toVc;
        self.fromVc = fromVc;
        self.animatorClassName = animatorName;
        self.presentationClassName = presentationClassName;
        [self configViewController];
    }
    return self;
}

- (void)transitionWithVc:(UIViewController *)vc
{
    self.toVc = vc;
    [self configViewController];
}


/**
 配置 呼出的交互转场
 */
- (void)configViewController
{
    //转场类型默认设置为Custom
//    self.transitionorType = KIVNavigationController;
//    self.toVc.modalPresentationStyle = UIModalPresentationCustom;
//    if (self.transitionorType == KIVNavigationController) {
//        [self navigationControllerPresetConfig];
//    }else if(self.transitionorType == KIVTabBarViewController){
//        UITabBarController *tabBarVc = (UITabBarController *)self.toVc;
//        tabBarVc.delegate = self;
//    }else  if(self.transitionorType == KIVViewController){
//        [self viewControllerPresetConfig];
//    }
    self.toVc.modalPresentationStyle = UIModalPresentationCustom;
    if ([self.toVc isKindOfClass:[UINavigationController class]]) {
        [self navigationControllerPresetConfig];
    }else if([self.toVc isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabBarVc = (UITabBarController *)self.toVc;
        tabBarVc.delegate = self;
    }else {
        [self viewControllerPresetConfig];
    }
}

#pragma mark vc模态转场配置
- (void)viewControllerPresetConfig
{
    self.toVc.transitioningDelegate = self;
    //是否支持转场
    [self presentingInTransitionConfig:self.toVc];
    [self presentingOutTransitionConfig:self.fromVc];
    
}

- (void)presentingInTransitionConfig:(UIViewController *)vc
{
    if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateSupportTransitioning)]) {
        if ([NSClassFromString(self.animatorClassName) animateSupportTransitioning]) {
            //只对呼出动画做交互转场转场
            self.percentDrivenOut = [[KIVPercentDrivenInteractiveTransition alloc] initWithPresentViewController:vc];
            self.percentDrivenOut.presentInter = YES;
            //交互方向
            if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateTransitioningDirection)]) {
                self.percentDrivenOut.direction = [NSClassFromString(self.animatorClassName) animateTransitioningDirection];
            }
        }
    }
}
/**
 配置呼入的交互转场

 @param presntingVc 呼入前的操作Vc
 */
- (void)presentingOutTransitionConfig:(UIViewController *)presntingVc
{
    if (!presntingVc) {
        return;
    }
    //是否支持转场
    if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateSupportTransitioning)]) {
        if ([NSClassFromString(self.animatorClassName) animateSupportTransitioning]) {
            //只对呼出动画做交互转场转场
            self.percentDrivenIn = [[KIVPercentDrivenInteractiveTransition alloc] initWithPresentViewController:self.toVc fromVc:presntingVc];
            self.percentDrivenIn.presentInter = NO;
            //交互方向
            if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateTransitioningDirection)]) {
                self.percentDrivenIn.direction = [NSClassFromString(self.animatorClassName) animateTransitioningDirection];
            }
        }
    }
}

#pragma mark - navigation 转场配置
- (void)navigationControllerPresetConfig
{
    UINavigationController *naviVc = (UINavigationController *)self.toVc;
    naviVc.delegate = self;
}

#pragma mark - UIViewControllerTransitioningDelegate
//动画
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorIn];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorOut];
}

//交互
- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator
{
    if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateSupportTransitioning)]) {
        if ([NSClassFromString(self.animatorClassName) animateSupportTransitioning]) {
            return  self.percentDrivenIn.isIteractive ? self.percentDrivenIn:nil;
        }
    }
    return  nil;
}

- (id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateSupportTransitioning)]) {
        if ([NSClassFromString(self.animatorClassName) animateSupportTransitioning]) {
             return  self.percentDrivenOut.isIteractive ? self.percentDrivenOut:nil;
        }
    }
    return nil;
}

///*
// precentController 和 animator的动画可以同时执行
// */
//使用precentController时 调用的代理方法
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    if (self.presentationClassName.length == 0) {
        return nil;
    }
    id presentObjct;
    if ([NSClassFromString(self.presentationClassName) instancesRespondToSelector:@selector(initWithPresentedViewController:presentingViewController:)]) {
        presentObjct = [[NSClassFromString(self.presentationClassName) alloc]  initWithPresentedViewController:presented presentingViewController:presenting];
    }
    if (![presentObjct isKindOfClass:[UIPresentationController class]]) {
        presentObjct = nil;
        return nil;
    }
    return presentObjct;
}

#pragma mark - UINavigationControllerDelegate
//动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorIn];
    }else if (operation == UINavigationControllerOperationPop){
        return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorOut];
    }
    return nil;
}

//交互
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
//    if ([NSClassFromString(self.animatorClassName) respondsToSelector:@selector(animateSupportTransitioning)]) {
//        if ([NSClassFromString(self.animatorClassName) animateSupportTransitioning]) {
//            return  self.percentDrivenOut.isIteractive ? self.percentDrivenIn:nil;
//        }
//    }
//    KIVPercentDrivenNavigationInteractiveTransition *navigationDriven = [[KIVPercentDrivenNavigationInteractiveTransition alloc] initWithPresentViewController:self.toVc fromVc:self.fromVc];
//    return  navigationDriven.isIteractive?navigationDriven:nil;
    return nil;
}


#pragma mark - UITabBarControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC
{
    NSInteger fromSelected = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toSelected = [tabBarController.viewControllers indexOfObject:toVC];
    if (fromSelected > toSelected) {
        return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorIn];
    }else{
        return [KIVAnimator animatorWith:self.animatorClassName withType:KIVAnimatorOut];
    }
    return nil;
}

@end
