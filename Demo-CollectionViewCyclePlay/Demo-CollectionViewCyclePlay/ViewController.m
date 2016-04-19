//
//  ViewController.m
//  Demo-CollectionViewCyclePlay
//
//  Created by cheng on 16/3/30.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "ViewController.h"
#import "CQFCollectionViewCell.h"
#import "CQFCollectionViewFlowLayout.h"
NSString * const cellIdentifior = @"CQFCycleCell";


@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, readwrite, strong)UICollectionView *collectionView;
@property (nonatomic, readwrite, strong)NSArray *imageName;
@property (nonatomic, readwrite, strong)NSArray *labelInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //CQFCollectionViewFlowLayout *flowLayout = [[CQFCollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3) collectionViewLayout:flowLayout];
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/3);//self.collectionView.frame.size;//
    flowLayout.sectionInset  = UIEdgeInsetsMake(0, 0, 0, self.view.frame.size.width*4);
    

    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[CQFCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifior];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //设置偏移量
    self.collectionView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    
    self.collectionView.backgroundColor= [UIColor grayColor];
    [self.view addSubview:self.collectionView];
    
    _imageName = @[@"h4.jpg",@"h1.jpg",@"h2.jpg",@"h3.jpg",@"h4.jpg",@"h1.jpg"];
    _labelInfo = @[@"4!",@"1",@"2",@"3",@"4",@"1!"];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageName.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CQFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifior forIndexPath:indexPath];
    cell.myImageView.image = [UIImage imageNamed:_imageName[indexPath.row]];
    cell.myLabel.text = _labelInfo[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    //[self scrollViewDidEndScrollingAnimation:scrollView];
    float contentOffsetWhenFullyScrolledRight = self.collectionView.frame.size.width * ([self.imageName count] -1);
    
    if (scrollView.contentOffset.x == contentOffsetWhenFullyScrolledRight) {
        // self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width, 0);
        NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    else if (scrollView.contentOffset.x == 0){
        // self.collectionView.contentOffset = CGPointMake(self.collectionView.frame.size.width * ([self.imageName count] -2), 0);
        NSIndexPath *path = [NSIndexPath indexPathForRow:self.imageName.count-2 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    
//    //NSLog(@"%d",decelerate);
//    if (decelerate) {
//        NSLog(@"scrollviiewDidEndDragging111111111111111");
//    }else{
//        NSLog(@"scrollviiewDidEndDragging222222222222222");
//    }
//}
//



@end
