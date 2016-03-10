//
//  MyLayout.h
//  PuBuLiuTest
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

//PS:如果自定义表明当前layout是完全重新绘制的 一定要实现对应的属性
@interface MyLayout : UICollectionViewLayout

//单元格数量
@property(nonatomic,assign)NSInteger itemCount;
//单元格高度数组
@property(nonatomic,strong)NSArray *heightArray;
//瀑布流距离屏幕边界的宽度
@property(nonatomic,assign)CGFloat marginToScreen;
@end
