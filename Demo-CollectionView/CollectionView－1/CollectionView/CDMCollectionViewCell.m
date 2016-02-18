//
//  CDMCollectionViewCell.m
//  CollectionView
//
//  Created by cheng on 16/2/11.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "CDMCollectionViewCell.h"

@interface CDMCollectionViewCell ()



@end

@implementation CDMCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectInset(self.bounds, 4.0f, 4.0f)];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_imageView];
    }
    return self;
}

@end
