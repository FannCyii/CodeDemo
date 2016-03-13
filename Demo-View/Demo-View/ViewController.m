//
//  ViewController.m
//  Demo-View
//
//  Created by cheng on 16/3/10.
//  Copyright © 2016年 cheng. All rights reserved.
//


#import "ViewController.h"
#import "DemoView.h"
#import "UIView+nameTag.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self printAllView];//打印子视图
    //[self chengeBounds];//改变bounds
    //[self myAffineTransform];
    [self myViewAnimation];
    
}


#pragma mark- print all subviews
- (void)print:(UIView *)aView
{
    //NSLog(@"[%@]",[[aView class] description]);
    NSLog(@"[%@]",aView);
    NSArray *sviews= [aView subviews];
    for (UIView *subview in sviews) {
       [self print:subview];
    }

}

- (void)printAllView
{
    
    DemoView *view1 = [[DemoView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    UIView *view2 = [[UIView alloc]init];
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [view1 addSubview:button1];
    button1.nameTag = @"view button";
    NSLog(@"%@",button1);
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    NSLog(@"%@",[self.view viewWithNameTag:@"view button"]);
    
    UIView * myView =[self.view viewWithNameTag:@"myview001"];
    NSLog(@"%@",myView);
    
    
    [self print:self.view];
}
#pragma mark - change the bounds
- (void)chengeBounds
{
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    view1.backgroundColor = [UIColor grayColor];
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 400, 200)];
    view2.backgroundColor = [UIColor redColor];
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(-20, 10, 100, 60)];
    button1.backgroundColor = [UIColor yellowColor];
    [view1 addSubview:button1];
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    //view1.clipsToBounds = YES;//设置为YES后button超出部分不能显示
    view1.clipsToBounds = NO;
    
    UILabel *myLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 50, 50)];
    myLable.text = @"XXXXXXXXXXXXXX";
    [self.view addSubview:myLable];
    [myLable sizeToFit];//自动调整UILable的长度，如果没有这句则不能显示所有的文本内容

    
}

#pragma mark - affine transform

- (void)myAffineTransform
{
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(100, 300, 100, 100)];
    myView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:myView];
    //frame = (100 300; 100 100)
    
    //CGAffineTransform myaffine = CGAffineTransformMake(2, 0, 0, 2, 0, 0);//x y轴分别拉升两倍，就是整个视图放大到原谅的两倍
    //myView.transform = myaffine;
    //CGAffineTransform myaffine2 = CGAffineTransformMakeScale(2,2);//效果和上述一样
    //myView.transform = myaffine2;
    
    CGAffineTransform myaffine3 = CGAffineTransformMakeRotation(3.1415026/4);
    myView.transform = myaffine3;
    //frame = (79.2893 279.289; 141.421 141.421);
    
    CGAffineTransform myaffine4 = CGAffineTransformIdentity;
    myView.transform = myaffine4;
    //frame = (100 300; 100 100);
    
}

#pragma mark - view animation

- (void)myViewAnimation
{
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(10, 100, 50, 50)];
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    /*
    
    [UIView animateWithDuration:3.0 animations:^{
        myView.frame = CGRectMake(self.view.bounds.size.width-50, 100, 50, 50);
        myView.alpha = 0;
        myView.transform = CGAffineTransformMakeRotation(3.1415926);
        
    } completion:^(BOOL finished) {
        NSLog(@"animation completion!");
    }];
     */
    
    
    
    
}



@end
