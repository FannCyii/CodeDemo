//
//  ViewController.m
//  CollectionView
//
//  Created by cheng on 16/2/11.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "ViewController.h"
#import "CDMCollectionViewDataSource.h"
#import "CDMCollectionViewCell.h"
#import "CDMPunchedLayout.h"

@interface ViewController ()<CDMCollectonViewCellConfigure>

@property (nonatomic, readwrite, strong)UICollectionView *collectionView;
@property (nonatomic, readwrite, strong)CDMCollectionViewDataSource *collectionViewDataSource;
@property (nonatomic, readonly, strong)NSArray *infoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureCollectionView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureCollectionView
{
    //创建流式布局对象
    CDMPunchedLayout *flowLayout = [[CDMPunchedLayout  alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置滚动方向
    //flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置条目大小
    //flowLayout.itemSize = CGSizeMake(100,100);
    //设置行间距
    //flowLayout.minimumLineSpacing = 10.0;
    //设置条目间间距
    //flowLayout.minimumInteritemSpacing = 10.0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.7];
    
    
    _collectionViewDataSource = [[CDMCollectionViewDataSource alloc]init];
    _collectionView.delegate = self;
    _collectionView.dataSource = _collectionViewDataSource;
    _collectionViewDataSource.cellConfigureDelegate = self;
    
    
    _infoArray = @[@"1",@"2",@"3",@"4",@"5"];
    _collectionViewDataSource.infoArray = _infoArray;
    
    [self.view addSubview: _collectionView];
    
}

#pragma mark - CDMCollectonViewCellConfigure delegate
- (void)collectionViewCellConfige:(id)cell info:(id)info
{
    CDMCollectionViewCell *mycell = cell;
    NSString *imageName = [NSString stringWithFormat:@"%@.png",info];
    
    mycell.imageView.image = [UIImage imageNamed:imageName];
    
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 20, 10, 20);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",_infoArray[indexPath.section]]];
    
    return image.size;
}


@end
