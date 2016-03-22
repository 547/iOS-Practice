
//
//  SWView.m
//  DrawingTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SWView.h"

@implementation SWView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


/*
  Quartz 2D：
 实际开发的过程中尽量不要使用以上这些方法来绘制内容和图片，因为用其绘制的内容和图片很耗费资源，UIlabel、UIimageView CAlayer都是底层做了最好的优化和处理使用它们就可以了。
 */


//绘制控件的时候调用
//PS:这个方法系统会自动调用，不要自己手动调用，如果实在需要用到这个方法的话可以通过[self setNeedsDisplay];帮助我们调用drawRect这个方法
- (void)drawRect:(CGRect)rect {
    
    //1.创建画布
    CGContextRef context=UIGraphicsGetCurrentContext();
    //2.设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    //3.设置画笔宽度
    CGContextSetLineWidth(context, 3.0f);
    //4.绘制形状===绘制的内容
    CGContextAddRect(context, CGRectMake(50, 50, 200, 200));
    //绘制圆
    CGContextAddEllipseInRect(context, CGRectMake(200, 200, 300, 300));
    //绘制椭圆
    CGContextAddEllipseInRect(context, CGRectMake(100, 260, 200, 300));

    //设置线段的起点
    CGContextMoveToPoint(context, 10, 100);
    //添加线段：线段的起始点如果不设置就默认为上一次画笔结束的点
    CGContextAddLineToPoint(context, 20, 200);
    /*
     绘制弧线:
     第2，3，4个参数是中心点x，y以及半径
     第5，6个参数是开始角度 结束角度
     第7个参数 顺逆时针（1顺时针，0逆时针）
    */
    CGContextAddArc(context, 200, 200, 50, M_PI, 1.5*M_PI, 1);
   
    //5.绘制
//    CGContextStrokePath(context);//用边框颜色绘图
    CGContextFillPath(context);//用填充颜色绘图
    
    //绘制字体
    [@"绘制字体" drawAtPoint:CGPointMake(100, 500) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    //设置图片
    UIImage *img=[UIImage imageNamed:@"1.png"];
    //旋转、平移、缩放（起始点变了，左下角是0，0）
    CGContextScaleCTM(context, 0.5, 0.5);//缩放
    CGContextRotateCTM(context, M_PI*0.2);//旋转
    //绘制图片
    CGContextDrawImage(context, CGRectMake(200, 200, 100, 100), img.CGImage);
}


@end
