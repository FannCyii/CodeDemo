//
//  ViewController.m
//  CustomCycleScrollView
//
//  Created by cheng on 16/3/24.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "ViewController.h"
#import "CCCycleScrollView.h"

@interface ViewController ()<CCCycleScrollViewClickActionDeleage>
@property (nonatomic, strong)CCCycleScrollView *cyclePlayView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cycleScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cycleScrollView
{
    NSMutableArray *images = [[NSMutableArray alloc]init];
    for (NSInteger i = 1; i <= 6; ++i) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"cycle_image%ld",(long)i]];
        [images addObject:image];
    }
    
    //self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images withFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.cyclePlayView = [[CCCycleScrollView alloc]initWithImages:images];
    self.cyclePlayView.pageDescrips = @[@"大海",@"花",@"长灯",@"阳光下的身影",@"秋树",@"摩天轮"];
    self.cyclePlayView.delegate = self;
    self.cyclePlayView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.cyclePlayView];

}

- (void)cyclePageClickAction:(NSInteger)clickIndex
{
    NSLog(@"点击了第%ld个图片:%@",clickIndex,self.cyclePlayView.pageDescrips[clickIndex]);
}

@end
