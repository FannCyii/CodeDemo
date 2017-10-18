//
//  EViewController.m
//  Present_Animation
//
//  Created by kivan on 13/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "EViewController.h"
#import "Transitioner.h"
#import "E2ViewController.h"

@interface EViewController ()

@property (nonatomic, strong) IBOutlet UIButton *showButton;
@property (nonatomic, strong) Transitioner *trasitioner;
@end

@implementation EViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showButton.layer.cornerRadius = (self.showButton.frame.size.width)/2;
    self.showButton.layer.borderWidth = 0.5;
    self.showButton.layer.borderColor = [UIColor redColor].CGColor;
    
    
    self.trasitioner = [[Transitioner alloc] init];
    self.trasitioner.transitionerType = TransitionerBubble;
    

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

- (IBAction)showButton:(UIButton *)sender {
    E2ViewController *E2VC = [[E2ViewController alloc] init];
    E2VC.view.backgroundColor = [UIColor redColor];
    E2VC.transitioningDelegate = self.trasitioner;
    E2VC.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:E2VC animated:YES completion:nil];
}

@end
