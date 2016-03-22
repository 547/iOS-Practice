//
//  SWLine.h
//  DrawingBoardTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
线的model
 */
@interface SWLine : UIView
-(id)initWithLineColor:(UIColor *)color;
@property(nonatomic,strong)NSMutableArray *points;
@property(nonatomic,assign)UIColor *lineColor;
@property(nonatomic,assign)CGFloat lineWidth;
@end
