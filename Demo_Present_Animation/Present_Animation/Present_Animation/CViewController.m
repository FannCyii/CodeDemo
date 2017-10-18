//
//  CViewController.m
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"dissmiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dissmiss:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dissmiss:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"C VC dissmiss");
    }];
}
@end
