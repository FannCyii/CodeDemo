//
//  UIView+nameTag.m
//  Demo-View
//
//  Created by cheng on 16/3/10.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "UIView+nameTag.h"
#import <objc/runtime.h>

@implementation UIView (nameTag)

static const char nameTag_key;

- (id)nameTag
{
   return objc_getAssociatedObject(self, (void *)&nameTag_key);
}

- (void)setNameTag:(NSString *)newNameTag
{
    objc_setAssociatedObject(self, (void *)&nameTag_key, newNameTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)viewWithNameTag:(NSString *)nameTag
{
    if (!nameTag) {
        return nil;
    }
    
    if ([self.nameTag isEqualToString:nameTag]) {
        return self;
    }
    
    for (UIView *subview in self.subviews) {
        UIView *resultView = [subview viewWithNameTag:nameTag];
        if (resultView) {
            return resultView;
        }
    }
    return nil;
}






@end
