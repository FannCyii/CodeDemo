//
//  CDMCollectionViewDataSource.m
//  CollectionView
//
//  Created by cheng on 16/2/11.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import "CDMCollectionViewDataSource.h"
#import "CDMCollectionViewCell.h"

static NSString *cellIdentifier = @"cellIdentifer";

@implementation CDMCollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.infoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerClass:[CDMCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    CDMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self.cellConfigureDelegate collectionViewCellConfige:cell info:self.infoArray[indexPath.row]];
    return cell;
}

@end



