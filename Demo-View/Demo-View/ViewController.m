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
    DemoView *view1 = [[DemoView alloc]initWithFrame:CGRectMake(100, 100, 200, 100)];
    UIView *view2 = [[UIView alloc]init];
    UIButton *button1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
    [view1 addSubview:button1];
    button1.nameTag = @"view button";
    NSLog(@"%@",button1);
    [self.view addSubview:view1];
    [self.view addSubview:view2];
    
    //[self printAllView];
    
    NSLog(@"%@",[self.view viewWithNameTag:@"view button"]);
}

- (void)print:(UIView *)aView
{
    //NSLog(@"[%@]",[[aView class] description]);
    NSLog(@"[%@]",aView);
    NSArray *sviews= [aView subviews];
    for (UIView *subview in sviews) {
       [self print:subview];
    }
}

-(void)printAllView
{
    [self print:self.view];
}



@end
