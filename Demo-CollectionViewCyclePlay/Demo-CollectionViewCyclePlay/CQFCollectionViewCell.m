//
//  CQFCollectionViewCell.m
//  Demo-CollectionViewCyclePlay
//
//  Created by cheng on 16/3/30.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "CQFCollectionViewCell.h"

@implementation CQFCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor yellowColor];
        [self setupImageView];
        [self setupLabel];
    }
    return self;
}


- (void)setupImageView
{
    _myImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:_myImageView ];
}

- (void)setupLabel
{
    _myLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.center.y, 60, 20)];
    _myLabel.backgroundColor = [UIColor redColor];
    [_myImageView addSubview:_myLabel];

}


@end
