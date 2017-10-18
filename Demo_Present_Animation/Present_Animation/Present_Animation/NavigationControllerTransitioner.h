//
//  NavigationControllerTransitioner.h
//  Present_Animation
//
//  Created by kivan on 05/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,NavigationControllerAnimationType) {
    NavigationControllerAnimationLeft,
    NavigationControllerAnimationRight,
    NavigationControllerAnimationUp,
    NavigationControllerAnimationDown,
};

@interface NavigationControllerTransitioner : NSObject <UINavigationControllerDelegate>
@property (nonatomic, assign)NavigationControllerAnimationType animationType;
@end
