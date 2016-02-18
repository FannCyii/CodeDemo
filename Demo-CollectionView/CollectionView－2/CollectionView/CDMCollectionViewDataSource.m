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


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.infoArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerClass:[CDMCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    CDMCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [self.cellConfigureDelegate collectionViewCellConfige:cell info:self.infoArray[indexPath.section]];
    return cell;
}

@end



