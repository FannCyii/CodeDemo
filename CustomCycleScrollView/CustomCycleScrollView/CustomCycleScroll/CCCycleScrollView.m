//
//  CCCycleScrollView.m
//  CustomCycleScrollView
//
//  Created by cheng on 16/3/24.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "CCCycleScrollView.h"

@interface CCCycleScrollView ()<UIScrollViewDelegate>

@property (nonatomic, readwrite, strong)UIImageView * leftImageView;
@property (nonatomic, readwrite, strong)UIImageView * middleImageView;
@property (nonatomic, readwrite, strong)UIImageView * rightImageView;
@property (nonatomic, readwrite, strong)UIScrollView * containerView;
@property (nonatomic, readwrite, strong)NSTimer *timer;
@property NSInteger currentNumber;

@end



@implementation CCCycleScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark - init function
- (instancetype)initWithImages:(NSArray *)images withFrame:(CGRect)frame
{
    return [self initWithImages:images withPageViewLocation:CCCycleScrollPageViewPositionBottomCenter withPageChangeTime:2.0f withFrame:frame];
}

- (instancetype)initWithImages:(NSArray *)images withPageViewLocation:(CCCycleScrollPageViewPosition)pageLocation withPageChangeTime:(NSTimeInterval)changeTime withFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        _images = [[NSArray alloc]initWithArray:images];
        _pageLocation = pageLocation;
        _pageChangeTime = changeTime;
        _currentNumber = 0;

        [self setCycleViewFrame:frame];
        
        //初始化容器ScrollView和三个imageview
        _containerView = [[UIScrollView alloc]initWithFrame:frame];
        _containerView.contentSize = CGSizeMake(3*frame.size.width, frame.size.height);
        _containerView.contentOffset = CGPointMake(self.frame.size.width, self.frame.origin.y)
        ;
        _containerView.delegate = self;
    
        [_containerView addSubview:_leftImageView];
        [_containerView addSubview:_rightImageView];
        [_containerView addSubview:_middleImageView];
        [self addSubview:_containerView];
        _containerView.scrollEnabled = YES;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.pagingEnabled = YES;
        
        //初始化pageControl
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self pageControlPosition:_pageLocation];
        [self addSubview:_pageControl];
        _pageControl.numberOfPages = _images.count;
        
        //初始化图片描述
        _pageDescripLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,_pageControl.frame.origin.y -10, self.frame.size.width, 40)];
        [_pageDescripLabel setTextAlignment:NSTextAlignmentRight];
        _pageDescripLabel.backgroundColor = [UIColor clearColor];
        _pageDescripLabel.textColor = [UIColor colorWithWhite:0.8 alpha:0.9];
        [self addSubview:_pageDescripLabel];
        
        
        [self cycleImageViewConfig];
        
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer   alloc]initWithTarget:self action:@selector(clickPageAction)];
        [self addGestureRecognizer:tap];

    }
    return self;
}

//设置三个imageview的位置
-(void)setCycleViewFrame:(CGRect)frame
{
    self.frame = frame;

    self.leftImageView  = [[UIImageView alloc]initWithFrame:frame];
    self.middleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width, frame.origin.y, frame.size.width, frame.size.height)];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(2*frame.size.width, frame.origin.y, frame.size.width, frame.size.height)];
}

//设置三个imageview的image
- (void)cycleImageViewConfig
{
    if ([_images count] == 0) {
        return;
    }
    
    _middleImageView.image = (UIImage *)_images[(_currentNumber+_images.count)%_images.count];
    _leftImageView.image = (UIImage *)_images[(_currentNumber+_images.count - 1)%(_images.count)];
    _rightImageView.image = (UIImage *)_images[(_currentNumber+_images.count + 1)%(_images.count)];
    
    [self timeSetter];
}

- (void)clickPageAction
{
    if ([self.delegate respondsToSelector:@selector(cyclePageClickAction:)]) {
            [self.delegate cyclePageClickAction:self.currentNumber];
    }
}

#pragma mark - timer
//设置定时器
- (void)timeSetter
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.pageChangeTime target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)timeChanged
{
    double page = (_pageControl.currentPage + 1) % self.images.count;
    _pageControl.currentPage = page;
    [self setPageDescripText];
    [self.containerView setContentOffset:CGPointMake(2*self.frame.size.width, 0) animated:YES];
    [self containerViewContentOffsetBack];
}

#pragma mark -UIScrollViewDelegate
//当用户手动个轮播时 关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

//当用户手指停止滑动图片时 启动定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self timeSetter];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self containerViewContentOffsetBack];
    self.pageControl.currentPage = self.currentNumber;
    [self changeImageViewWith:self.currentNumber];
    [self setPageDescripText];
}

- (void)containerViewContentOffsetBack
{
    CGPoint offset = [self.containerView contentOffset];
    if (offset.x == 2*self.frame.size.width) {
        self.currentNumber = (self.currentNumber + 1 + self.images.count)%(self.images.count);
    } else if (offset.x == 0){
        self.currentNumber = (self.currentNumber - 1 + self.images.count)%(self.images.count);
    }else{
        return;
    }
    self.containerView.contentOffset = CGPointMake(self.frame.size.width, self.frame.origin.y);
}


#pragma mark - judge the pageControl's position
//确定pageControl的位置，可以自定义设置
- (void)pageControlPosition:(CCCycleScrollPageViewPosition)position
{
    
    if (position == CCCycleScrollPageViewPositionBottomCenter ) {
        _pageControl.frame = CGRectMake(self.center.x - 50, self.frame.size.height -30, 100, 30);
    }else if (position == CCCycleScrollPageViewPositionBottomLeft)
    {
        _pageControl.frame = CGRectMake(50, self.frame.size.height -30, 100, 30);
    
    }else if (position == CCCycleScrollPageViewPositionBottomRight)
    {
        _pageControl.frame = CGRectMake(self.frame.size.width - 100-20, self.frame.size.height -30, 100, 30);
    }

}

- (void)setPageLocation:(CCCycleScrollPageViewPosition)pageLocation
{
    [self pageControlPosition:pageLocation];
}

#pragma mark - iamgeView cycle changed 
//改变轮播的图片
- (void)changeImageViewWith:(NSInteger)imageNumber
{
    self.middleImageView.image = self.images[(imageNumber + self.images.count)%self.images.count];
    self.leftImageView.image = self.images[(imageNumber-1+self.images.count)%self.images.count];
    self.rightImageView.image = self.images[(imageNumber+1+self.images.count)%self.images.count];
    
}


//描述
- (void)setPageDescrips:(NSArray *)pageDescrips
{
    _pageDescrips = [[NSArray alloc]initWithArray:pageDescrips];
    [self setPageDescripText];
}

- (void)setPageDescripText
{
    self.pageDescripLabel.text = self.pageDescrips[self.pageControl.currentPage];
    [self.pageDescripLabel sizeToFit];
}

@end
