//
//  MyCollectionViewFlowLayout.m
//  FallsWithCollectionViewTest
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyCollectionViewFlowLayout.h"
static int defaultColumsCount=3;//默认列数
static UIEdgeInsets defaultInSets={10,0,0,10};//默认每个cell上下左右的间距
static CGFloat miniColumsMargin=0;//默认最小列间距
static CGFloat miniRowMargin=10;//默认最小行间距

@implementation MyCollectionViewFlowLayout
#pragma mask==懒加载
-(NSMutableArray *)columnMaxY
{
    if (!_columnMaxY) {//如果_columaMaxY没有的话，就初始化，不然直接返回_columaMaxY
        _columnMaxY=[[NSMutableArray alloc]init];
    }
    return _columnMaxY;
}
-(NSMutableArray *)atuArray
{
    if (!_atuArray) {//如果_atuArray没有的话，就初始化，不然直接返回_atuArray
        _atuArray=[[NSMutableArray alloc]init];
    }
    return _atuArray;
}
#pragma mask==实现的内部方法
/*
 决定collectionView的contentSize
 */
-(CGSize)collectionViewContentSize//重写父类方法
{
//找出最长那一列的最大Y值
    CGFloat destMaxY=[self.columnMaxY[0] floatValue];
    for (int i=0; i<self.columnMaxY.count; i++) {
        //取出第i列的最大Y值
        CGFloat columnY=[self.columnMaxY[i]floatValue];
        //找到数组中的最大值
        if (destMaxY<columnY) {
            destMaxY=columnY;
        }
    }
    return CGSizeMake(0, destMaxY+defaultInSets.bottom);
}
-(void)prepareLayout//重写父类方法===prepare==准备
{
    [super prepareLayout];
    //重置每一列的最大Y值
    [self.columnMaxY removeAllObjects];
    for (int i=0; i<defaultColumsCount; i++) {
        [self.columnMaxY addObject:@(defaultInSets.top)];
    }
    //计算所有cell的布局属性
    [self.atuArray removeAllObjects];
    NSInteger cellCount=[self.collectionView numberOfItemsInSection:0];//获取collectionView中的cell总数
    for (int i=0; i<cellCount; ++i) {
        NSIndexPath *indexPath=[NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *cellAttri=[self layoutAttributesForItemAtIndexPath:indexPath];//获取指定索引下的单元格的布局属性
        [self.atuArray addObject:cellAttri];
    }
    
    

}
@end
