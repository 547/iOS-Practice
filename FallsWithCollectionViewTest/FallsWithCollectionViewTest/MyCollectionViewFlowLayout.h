//
//  MyCollectionViewFlowLayout.h
//  FallsWithCollectionViewTest
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewFlowLayout : UICollectionViewLayout
@property(nonatomic,strong)NSMutableArray *columnMaxY;//每一列的最大Y值；
@property(nonatomic,strong)NSMutableArray *atuArray;//所有cell的布局属性
@end
