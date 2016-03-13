//
//  ViewController.m
//  Demo-View-affineTransform
//
//  Created by cheng on 16/3/13.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,readwrite, strong)UISlider *transformSlider;
@property (nonatomic,readwrite, strong)UILabel * transformAngleLable;
@property float angleOrigin;


@property (nonatomic,readwrite, strong)UISlider *transformScaleSlider;
@property (nonatomic,readwrite, strong)UILabel * transformScaleLable;
@property float scaleOrigin;


@property (nonatomic,readwrite, strong)UIView * myView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.angleOrigin = 1.0f;
    self.scaleOrigin = 1.0f;
    
    UIButton *originButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.bounds.size.width - 100,80, 80, 40)];
    [originButton setTitle:@"复原" forState:UIControlStateNormal];
    originButton.backgroundColor = [UIColor grayColor];
    [self.view addSubview:originButton];
    [originButton addTarget:self action:@selector(changeToOrigin) forControlEvents:UIControlEventTouchUpInside];
    
    self.transformAngleLable= [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 200, 20)];
    self.transformAngleLable.text = @"旋转角度:0.00";
    [self.view addSubview:self.transformAngleLable];
    
    self.transformScaleLable= [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 20)];
    self.transformScaleLable.text = @"放大(倍):0.00";
    [self.view addSubview:self.transformScaleLable];
    
    self.myView = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x - 80, 150, 160, 160)];
    self.myView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.myView];
    
    [self sliderTransformConfiger];
    [self sliderScaleConfiger];

}

- (void)changeToOrigin
{
    self.transformAngleLable.text = @"旋转角度:0.00";
    self.transformSlider.value = 0.00;
    self.transformScaleSlider.value = 1.0;
    self.myView.transform = CGAffineTransformIdentity;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - slider 
- (void)sliderTransformConfiger
{
    self.transformSlider = [[UISlider alloc]initWithFrame:CGRectMake(self.view.center.x-150, 400, 300, 30)];
    [self.view addSubview:self.transformSlider];
    self.transformSlider.maximumValue = 3.14;
    self.transformSlider.minimumValue = -3.14;
    self.transformSlider.value = 0;
    
    [self.transformSlider addTarget:self action:@selector(changeLable:) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderScaleConfiger
{
    self.transformScaleSlider = [[UISlider alloc]initWithFrame:CGRectMake(self.view.center.x-150, 450, 300, 30)];
    [self.view addSubview:self.transformScaleSlider];
    self.transformScaleSlider.maximumValue = 2;
    self.transformScaleSlider.minimumValue = 0;
    self.transformScaleSlider.value = 1;
    
    [self.transformScaleSlider addTarget:self action:@selector(changeLable:) forControlEvents:UIControlEventValueChanged];
}

- (void)changeLable:(id)sender
{
    UISlider* control = (UISlider*)sender;
    if (control == self.transformSlider) {
        self.transformAngleLable.text = [NSString stringWithFormat:@"旋转角度:%.2f",360*control.value/3.14];
        [self.transformAngleLable sizeToFit];
        
        self.myView.transform = CGAffineTransformRotate(self.myView.transform,control.value/self.angleOrigin);
        self.angleOrigin = control.value;
        
    }else  if (control == self.transformScaleSlider) {
        self.transformScaleLable.text = [NSString stringWithFormat:@"放大(倍):%.2f",control.value];
        [self.transformScaleSlider sizeToFit];
        
        //self.myView.transform = CGAffineTransformScale(self.myView.transform,control.value, control.value);
        self.myView.transform = CGAffineTransformScale(self.myView.transform,control.value/self.scaleOrigin, control.value/self.scaleOrigin);
        
        self.scaleOrigin = control.value;
    }
}




@end
