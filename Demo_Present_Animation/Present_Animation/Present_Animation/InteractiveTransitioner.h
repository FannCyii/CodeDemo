//
//  InteractiveTransitioner.h
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InteractiveTransitioner : UIPercentDrivenInteractiveTransition
@property (nonatomic, assign) BOOL interacting;

- (void)interactiveTransitionWith:(UIViewController *)vc fromVc:(UIViewController *)vc;

@end
