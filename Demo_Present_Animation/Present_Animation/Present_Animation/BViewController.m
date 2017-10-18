//
//  BViewController.m
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "BViewController.h"
#import "DViewController.h"
#import "Transitioner.h"

@interface BViewController ()
@property (nonatomic, strong) DViewController *DVC;

//@property (nonatomic, strong) UIView *panView;
@property (nonatomic, assign) BOOL movePanViewFlag;

@end

@implementation BViewController{
    CGFloat _startPointX;
    CGFloat _startPointY;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"dissmiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dissmiss:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button1  = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    [self.view addSubview:button1];
    button1.backgroundColor = [UIColor grayColor];
    [button1 setTitle:@"presentCVC" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(presentDVC:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2  = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    [self.view addSubview:button2];
    button2.backgroundColor = [UIColor grayColor];
    [button2 setTitle:@"popVc" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(popVc:) forControlEvents:UIControlEventTouchUpInside];
    
    self.DVC = [[DViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dissmiss:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"BVC dissmiss");
    }];
}

- (void)presentDVC:(UIButton *)button
{
    [self presentViewController:self.DVC animated:YES completion:^{
        NSLog(@"present C VC");
    }];
}
- (void)popVc:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
