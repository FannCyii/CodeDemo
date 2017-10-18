//
//  D2ViewController.m
//  Present_Animation
//
//  Created by kivan on 14/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "D2ViewController.h"

@interface D2ViewController ()

@end

@implementation D2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
        NSLog(@"D VC dissmiss");
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
