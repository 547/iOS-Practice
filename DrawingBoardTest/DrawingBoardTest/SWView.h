//
//  SWView.h
//  DrawingBoardTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 自定义的View，继承自UIView
 Quartz 2D的核心，画图主要是在这里实现的
 */
@interface SWView : UIView

@property(nonatomic,strong)NSMutableArray *lines;


@end
