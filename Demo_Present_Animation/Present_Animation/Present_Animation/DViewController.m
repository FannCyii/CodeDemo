//
//  DViewController.m
//  Present_Animation
//
//  Created by kivan on 13/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "DViewController.h"
#import "D2ViewController.h"
#import "KIVTransitionor.h"

@interface DViewController ()
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, strong) KIVTransitionor *transitionor;
@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"dissmiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dissmiss:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dissmiss:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"D VC dissmiss");
    }];
}
- (IBAction)pressentD2VC:(UIButton *)sender {
    D2ViewController *d2VC = [[D2ViewController alloc] init];
    self.transitionor = [[KIVTransitionor alloc] initWith:d2VC animatorClassName:@"AnimatorBubble"];
    [self presentViewController:d2VC animated:YES completion:nil];
}

@end
