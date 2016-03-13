//
//  DemoView.m
//  Demo-View
//
//  Created by cheng on 16/3/10.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "DemoView.h"

@implementation DemoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setOrigin:(CGPoint)myPoint
{
    CGRect myframe = self.frame;
    myframe.origin = myPoint;
    self.frame = myframe;
}

@end
