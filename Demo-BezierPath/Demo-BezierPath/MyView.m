//
//  MyView.m
//  Demo-BezierPath
//
//  Created by cheng on 16/3/19.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    //三角形
    //[self bezierPathTriangleTest];
    
    //柜形
    //[self bezierPathRectTest];
    
     //椭圆
    //[self bezierPathOvalTest];
    
    //固定四个圆角
    //[self bezierPathRadiusTest];
    
    //不固定圆角
    //[self bezierPathRadius2Test];
    
    //画弧
    //[self bezierPathArcTest];
    
    //根据CGPath来绘图
    [self bezierPathCGPathTest];
    
}



- (void)bezierPathTriangleTest
{
    /**
     *  + (instancetype)bezierPath;
     *直接创建一个贝赛尔路径，之后通过系统一系列路径构造函数来创造路径，如下面的画直线
     */
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(20, 20)];
    
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width - 40, 20)];
    [bezierPath addLineToPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20)];
    
    [bezierPath closePath];
    
    bezierPath.lineWidth = 2.0;
    
    UIColor *fillColor = [UIColor redColor];
    [fillColor set];//UIColor的set方法为设置当前绘画的画笔颜色
    [bezierPath fill];//填充，在填充前想设置自己的填充色，需要改变当前环境的绘画颜色，当前绘画颜色只有一中，下面 描边 需要再次修改成自己想要的颜色，如果不修改则将会会延续之前设置好的颜色。系统默认为黑色
    
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    [bezierPath stroke];//描边

}

- (void)bezierPathRectTest
{
    /**
     *  + (instancetype)bezierPathWithRect:(CGRect)rect;
     *
     *  rect  画柜形
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 200, 200)];
    
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    [path stroke];
    
    UIColor *fillColor = [UIColor yellowColor];
    [fillColor set];
    [path fill];
    
}

- (void)bezierPathOvalTest
{
    /**
     *  + (instancetype)bezierPathWithOvalInRect:(CGRect)rect;
     *
     *  rect 根据这个柜形画圆（内嵌），如果举行为正方形则画的是圆，如果柜形是长方形则画的是椭圆
     *
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 200, 200)];
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];
    
    UIColor *fillColor = [UIColor grayColor];
    [fillColor set];
    [path fill];
    
    //椭圆
    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 400, 100, 200)];
    
    UIColor *strokeColor2 = [UIColor redColor];
    [strokeColor2 set];
    [path2 stroke];
    
    UIColor *fillColor2 = [UIColor greenColor];
    [fillColor2 set];
    [path2 fill];
    
}

//固定圆角
- (void)bezierPathRadiusTest
{
    /**
     *  + (instancetype)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius; // rounds all corners with the same horizontal and vertical radius
     *
     *  rect 柜形形状，默认为圆角
     *  cornerRadius  圆角半径
     *
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 20, 200, 40) cornerRadius:10.0];
    
//    UIColor *fillcolor = [UIColor grayColor];
//    [fillcolor set];
//    [path fill];
    
    UIColor *strokeColor = [UIColor greenColor];
    [strokeColor set];
    [path stroke];
    

}

//不固定圆角
- (void)bezierPathRadius2Test
{
    /**
     *  + (instancetype)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
     *
     *  rect 柜形形状大小，默认为直角
     *  corners  为圆角的角 使用'｜'来添加多个角
     *  cornerRadii 圆角半径
     *
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 20, 200, 40)  byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(20, 10)];
    
    [path stroke];
    
    UIColor *fillColor = [UIColor purpleColor];
    [fillColor set];
    [path fill];
    
}

//画弧
- (void)bezierPathArcTest
{
    
    /**+ (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
     *
     *  center  弧的原点
     *  radius  弧的半径
     *  startAngle 弧的起始角度， 水平右侧为0或2PI
     *  endAngle  弧的结束角度
     *  clockwise  是否顺时针
     */
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 100) radius:200.0 startAngle:M_PI_4 endAngle:M_PI clockwise:YES];
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    [path stroke];
    
}

//根据UIPath来绘制图形
- (void)bezierPathCGPathTest
{
    CGMutablePathRef path = CGPathCreateMutable();
    
   
    CGRect rect = self.frame;
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
    
//    //直接使用CGContext绘图
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取系统当前绘图上下文
//    CGPathCloseSubpath(path);//闭合曲线，此处为连接两个点成为一条直线
//    CGContextAddPath(ctx, path);//添加绘图路径
//    CGContextSetStrokeColorWithColor(ctx,[UIColor redColor].CGColor);//改变画图颜色
//    CGContextStrokePath(ctx);//描边
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithCGPath:path];
    UIColor * strokeColor = [UIColor greenColor];
    [strokeColor set];
    [bezierPath stroke];
    
    
    NSLog(@"%@",bezierPath.CGPath);
}


@end
