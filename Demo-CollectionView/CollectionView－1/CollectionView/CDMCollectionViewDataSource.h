//
//  CDMCollectionViewDataSource.h
//  CollectionView
//
//  Created by cheng on 16/2/11.
//  Copyright © 2016年 cheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol CDMCollectonViewCellConfigure <NSObject>

- (void)collectionViewCellConfige:(id)cell info:(id)info;

@end





@interface CDMCollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, weak)id<CDMCollectonViewCellConfigure> cellConfigureDelegate;
@property (nonatomic, strong)NSArray *infoArray;


@end
