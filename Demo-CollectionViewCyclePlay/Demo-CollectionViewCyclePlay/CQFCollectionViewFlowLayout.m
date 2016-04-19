//
//  CQFCollectionViewFlowLayout.m
//  Demo-CollectionViewCyclePlay
//
//  Created by cheng on 16/4/6.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "CQFCollectionViewFlowLayout.h"

@implementation CQFCollectionViewFlowLayout


- (void)prepareLayout
{
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
 
    NSLog(@"rect:%@",NSStringFromCGRect(rect));
    
    /* */
    CGSize contentSize = [super collectionViewContentSize];
    NSLog(@"contentSize.width:%f",contentSize.width);
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    
    for (NSInteger i = 0; i < attributesArray.count; ++i) {
        
        UICollectionViewLayoutAttributes *attribute = attributesArray[i];
        CGRect frame =  attribute.frame;
        frame.origin.x =i*frame.size.width;//i*50;//i*frame.size.width;
        attribute.frame = frame;
    }
    
    
    for (UICollectionViewLayoutAttributes *attribute in attributesArray ) {
        NSLog(@"%@",NSStringFromCGRect([attribute frame]));
        //CGRect frame = attribute.frame;

    }
    
    return attributesArray;
    
    NSIndexPath * indexPath = [self indexOfItemWith:rect];
    
    
    NSMutableArray *layoutAtrributes = [NSMutableArray array];
    
//    for (NSInteger i = 0; i < 4; ++i) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//    }
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    [layoutAtrributes addObject:attributes];
    
    return layoutAtrributes;
}

- (NSIndexPath *)indexOfItemWith:(CGRect)rect
{
    //CGSize contentSize = [super collectionViewContentSize];
    NSInteger index = (rect.origin.x)/rect.size.width;
    NSLog(@"%ld",(long)index);
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];//[NSIndexPath indexPathWithIndex:index];
    NSLog(@"%ld",indexPath.row);
    return indexPath;
}

@end
