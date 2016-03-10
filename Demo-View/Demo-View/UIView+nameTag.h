//
//  UIView+nameTag.h
//  Demo-View
//
//  Created by cheng on 16/3/10.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (nameTag)

@property(nonatomic)NSString *nameTag;

- (UIView *)viewWithNameTag:(NSString *)nameTag;
@end
