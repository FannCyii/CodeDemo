//
//  E2ViewController.m
//  Present_Animation
//
//  Created by kivan on 13/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "E2ViewController.h"

@interface E2ViewController ()
@property (nonatomic, strong) UIButton *showButton;
@end

@implementation E2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showButton  = [[UIButton alloc] initWithFrame:CGRectMake(164, 492, 50, 50)];
    self.showButton.backgroundColor = [UIColor whiteColor];
    self.showButton.layer.cornerRadius = (self.showButton.frame.size.width)/2;
    self.showButton.layer.borderWidth = 0.5;
    self.showButton.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.view addSubview:self.showButton];
    [self.showButton addTarget:self action:@selector(dismissVC:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dismissVC:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
