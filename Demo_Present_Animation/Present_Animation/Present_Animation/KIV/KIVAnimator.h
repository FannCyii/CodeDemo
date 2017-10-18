//
//  KIVAnimator.h
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KIVAnimateTransitioning.h"

typedef NS_ENUM(NSInteger, KIVAnimatorType){
    KIVAnimatorNone,
    KIVAnimatorIn,
    KIVAnimatorOut,
};

@interface KIVAnimator : NSObject <UIViewControllerAnimatedTransitioning>
+ (instancetype)animatorWith:(NSString *)animatorClassName withType:(KIVAnimatorType)animatorType;
@end
