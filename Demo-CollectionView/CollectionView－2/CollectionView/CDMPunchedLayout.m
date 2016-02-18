//
//  CDMPunchedLayout.m
//  CollectionView
//
//  Created by cheng on 16/2/11.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "CDMPunchedLayout.h"

@implementation CDMPunchedLayout{
    CGSize boundsSize;
    CGFloat midX;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (void)prepareLayout
{
    [super prepareLayout];
    boundsSize = self.collectionViewContentSize;
    midX = boundsSize.width/2;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in array)
    {
        attributes.transform3D  = CATransform3DIdentity;
        if (!CGRectIntersectsRect(attributes.frame, rect)) continue;
        CGPoint contentOffset = self.collectionView.contentOffset;
        CGPoint itemCenter = CGPointMake(attributes.center.x - contentOffset.x, attributes.center.y - contentOffset.y );
        CGFloat distance = ABS(midX - itemCenter.x);
        
        CGFloat normalized = distance/midX;
        normalized = MIN(normalized, 1.0f);
        CGFloat zoom = cos(normalized*M_PI_4*1.5);
        
        attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0f);
    }
    return array;
}

@end
