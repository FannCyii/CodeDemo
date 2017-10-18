//
//  Animator.h
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TransitionType) {
    TransitionPresentType,
    TransitionDissmissType,
    TransitionPushLeftType,
    TransitionPopLeftType,
    TransitionPushRightType,
    TransitionPopRightType,
    TransitionUpType,
    TransitionDownType,
    TransitionBubbleOut,
    TransitionBubbleIn,
};

@interface Animator : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) TransitionType transitionType;

@end
