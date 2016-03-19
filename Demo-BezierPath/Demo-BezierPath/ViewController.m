//
//  ViewController.m
//  Demo-BezierPath
//
//  Created by cheng on 16/3/19.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyView *myView = [[MyView alloc]initWithFrame:self.view.frame];
    myView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:myView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
