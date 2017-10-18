//
//  Transitioner.h
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "InteractiveTransitioner.h"
typedef NS_ENUM(NSInteger,TransitionerType) {
    TransitionerNone,
    TransitionerBubble,
};


@interface Transitioner : NSObject <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) InteractiveTransitioner *interactiveTransor;

@property (nonatomic, assign) TransitionerType transitionerType;
@end
