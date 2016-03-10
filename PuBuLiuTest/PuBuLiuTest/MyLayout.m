//
//  MyLayout.m
//  PuBuLiuTest====自定义Layout
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyLayout.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEUGHT [UIScreen mainScreen].bounds.size.height
/**
实现瀑布流的核心是：自定义UICollectionViewFlowLayout
自定义UICollectionViewFlowLayout必须重写的方法：
 1.-(void)prepareLayout==相当于init，在这个方法里面初始化所有属性
 2.- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect===PS：必须重写==返回一个装Attribute的数组===继prepareLayout之后调用的方法
 3.-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath==通过所在的indexpath返回Attribute==确定位置==单元格的具体属性如：frame等，必须有Frame（最基本的），不然不会显示单元格在collectionView中===这个方法是在第二步的方法内调用的方法，是为了获取每个单元格的属性（在这个方法内设置单元格的属性）
 4.-(CGSize)collectionViewContentSize====这里是返回collectionView的Frame的Size，PS：为了能使collectionView可以滑动，高必须动态设置成个高的列的高度，不可以偷懒直接写成self.collectionView.frame.size
 
 **/
@implementation MyLayout
{
    CGFloat OSy;//偶数列的y坐标
    CGFloat JSy;//奇数列的y坐标
}
//相当于init
-(void)prepareLayout//在这个方法里面初始化所有属性
{

    //获取单元格个数
    //[[self collectionView]numberOfItemsInSection:0]获取对应区的个数
    self.itemCount=[[self collectionView]numberOfItemsInSection:0];
    
}
//返回collectionView的内容的尺寸===必须重写
-(CGSize)collectionViewContentSize
{
//    return CGSizeMake(SCREENWIDTH, Righty>Lefty?Righty:Lefty);
    
    //这里是返回collectionView的Frame的Size，PS：为了能使collectionView可以滑动，高必须动态设置成个高的列的高度，不可以偷懒直接写成self.collectionView.frame.size
    
    return CGSizeMake(SCREENWIDTH, OSy>JSy?OSy:JSy);

}

//PS：必须重写==返回一个装Attribute的数组===继prepareLayout之后调用的方法
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //设置y坐标的初始值
    JSy=0.0;
    OSy=0.0;
    
   
    NSMutableArray *attributesArray=[[NSMutableArray alloc]init];//用于装Attribute将来返回出去
    
    for (NSInteger i=0; i<self.itemCount; i++) {//根据单元格的总数遍历获取单元格的indexPath，从而获取到每一个单元格的属性，并将属性加入到属性数组中
        
        NSIndexPath *indepath=[NSIndexPath indexPathForItem:i inSection:0];//获取indexPath
        
        //根据上面获取的indexPath获取相应单元格的属性==attributes
        [attributesArray addObject:[self layoutAttributesForItemAtIndexPath:indepath]];//调用下面👇的方法获得每一个单元格的属性👇👇👇👇👇
    }
    
    return attributesArray;
}
//通过所在的indexpath确定位置==单元格的具体属性如：frame等，必须有Frame（最基本的），不然不会显示单元格在collectionView中
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];//创建一个UICollectionViewLayoutAttributes对象，用于设置属性
    
    //添加属性
    CGFloat height= [self.heightArray[indexPath.row] floatValue];//通过indexPath.row从高度数组中获取某个数组的高度
    
    CGSize size=CGSizeMake(SCREENWIDTH*0.5-_marginToScreen, height);//设置单元格的size==SCREENWIDTH==屏幕宽
    
    if (indexPath.row%2==1) {//奇数列===右边
        
        attributes.frame=(CGRect){{SCREENWIDTH*0.5,JSy},size};//设置单元格的frame
        
        JSy+=height;//上一行的高度给下一行做y坐标
    }else{//偶数列===左边==从0开始
        
        attributes.frame=(CGRect){{_marginToScreen,OSy},size};//设置单元格的frame
        
        OSy+=height;//上一行的高度给下一行做y坐标
    }
    
    return attributes;//返回单元的属性
}
@end
