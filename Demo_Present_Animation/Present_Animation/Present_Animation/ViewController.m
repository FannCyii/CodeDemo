//
//  ViewController.m
//  Present_Animation
//
//  Created by kivan on 04/09/2017.
//  Copyright © 2017 kivan. All rights reserved.
//

#import "ViewController.h"
#import "BViewController.h"

#import "Transitioner.h"
#import "InteractiveTransitioner.h"
#import "NavigationControllerTransitioner.h"
#import "TabBarControllerTransitioner.h"
#import "KIVTransitionor.h"
#import "SettingViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) BViewController *bVC;
@property (nonatomic, strong) Transitioner *transitioner;
@property (nonatomic, strong) NavigationControllerTransitioner * navigationTransitioner;
@property (nonatomic, strong) TabBarControllerTransitioner *tabBarTransitioner;
@property (nonatomic, strong) UIButton *panView;
@property (nonatomic, strong) KIVTransitionor *tabTra;
@property (nonatomic, strong) KIVTransitionor *naviTra;
@property (nonatomic, strong) KIVTransitionor *vcTra;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.panView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.panView];
    
    UIPanGestureRecognizer *panViewGeseter = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panToMoveView:)];
    [self.panView addGestureRecognizer:panViewGeseter];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.titleArray = @[@[@"None",@"UpAndDown",@"Bubble",@"Explode",@"Cards",@"Pan",@"PushAndPop",@"Right"],
                        @[@"None",@"HalfRightIn",@"UpAndDown",@"Pan",@"Spring"],
                        @[@"None",@"Explode",@"UpAndDown",@"Cards",@"Pan"],
                        @[@"Right"]
                        ];
    //VC
    self.bVC = [[BViewController alloc] init];
    self.vcTra  = [[KIVTransitionor alloc] initWith:self.bVC animatorClassName:@"AnimatorHalfRightIn"];
    //navigation
    self.naviTra = [[KIVTransitionor alloc] initWith:self.navigationController animatorClassName:@"AnimatorPan"];
//    self.naviTra = [[KIVTransitionor alloc] initWithNavigation:self.navigationController fromVc:self animatorClassName:@"AnimatorPan" presentationController:nil];
    //tabbar
    self.tabTra = [[KIVTransitionor alloc] initWith:self.tabBarController animatorClassName:@"AnimatorExplode"];
}

- (UIButton *)panView
{
    if (!_panView) {
        _panView = [[UIButton alloc] initWithFrame:CGRectMake(10 , 500, 40, 40)];
        self.panView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.6];
        _panView.layer.cornerRadius = (40)/2;
        _panView.layer.borderWidth = 0.5;
        _panView.layer.borderColor = [UIColor blackColor].CGColor;
        [_panView addTarget:self action:@selector(goToSettingVc:) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _panView;
}
- (void)goToSettingVc:(UIButton *)button
{
    SettingViewController *settingVc = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:nil];
    [self presentViewController:settingVc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)presentBVC:(UIButton *)sender {
    BViewController *bvc = [[BViewController alloc] init];
    [self.vcTra transitionWithVc:bvc];
    [self presentViewController:bvc animated:YES completion:nil];
}

- (IBAction)pushAction:(UIButton *)sender {
    [self.navigationController pushViewController:[[BViewController alloc] init] animated:YES];
}

- (void)panToMoveView:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
    }else if (gesture.state == UIGestureRecognizerStateChanged){
        
        CGPoint po = [gesture translationInView:self.view];
        //注意这里的translation指的都是偏移量，而不是坐标
        //返回移动中两点之间的偏移量，相对于上一点的坐标
        CGPoint p1 = [gesture translationInView:self.view];
        NSLog(@"%f,%f",p1.x,p1.y);
        
        self.panView.center = CGPointMake(self.panView.center.x + po.x, self.panView.center.y + po.y);
        //设置手势的translation， 将相对于inView的坐标系中的偏移 设置为给定的偏移量
        [gesture setTranslation:CGPointMake(0, 0) inView:self.panView];
        
        //返回手势水平和垂直的速度，每秒,先对坐标系为InView
        //CGPoint veloci = [gesture velocityInView:self.view];
        
    }else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateEnded){
        
    }
}
#pragma mark - tableviewDataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = [self.titleArray objectAtIndex:section];
    return sectionArray.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return  @"Navigation Animator";
    }else if(section == 1){
        return  @"Present Animator";
    }else if(section == 2){
        return  @"TabBar Animator";
    }else if(section == 3){
        return  @"PresentationController";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArray = [self.titleArray objectAtIndex:indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [sectionArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionArray = [self.titleArray objectAtIndex:indexPath.section];
    NSString * className = [NSString stringWithFormat:@"Animator%@", sectionArray[indexPath.row]];
    if (indexPath.section == 0) {
        self.naviTra = [[KIVTransitionor alloc] initWith:self.navigationController fromVc:self animatorClassName:className presentationController:@"CustomPresentationControllerRight"];
    }else if(indexPath.section == 1){
        self.vcTra = [[KIVTransitionor alloc] initWith:self.bVC animatorClassName:className];
    }else if (indexPath.section == 2){
        self.tabTra = [[KIVTransitionor alloc] initWith:self.tabBarController animatorClassName:className];
    }else if(indexPath.section == 3){
        self.vcTra = [[KIVTransitionor alloc] initWith:self.bVC fromVc:self animatorClassName:className presentationController:@"CustomPresentationControllerRight"];
    }
}

@end
