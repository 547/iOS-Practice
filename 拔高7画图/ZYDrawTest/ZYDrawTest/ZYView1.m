//
//  ZYView1.m
//  ZYDrawTest
//
//  Created by broncho on 16/3/22.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYView1.h"

@implementation ZYView1
//绘制控件的时候调用
//切记不要手动调用该方法  如果需要用到这个方法的话可以通过[self setNeedsDisplay];来让系统帮助调用drawRect
- (void)drawRect:(CGRect)rect
{
    //创建画布
    CGContextRef  context =UIGraphicsGetCurrentContext();
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor redColor]CGColor]);
    //设置画笔宽度
    CGContextSetLineWidth(context, 5.0f);
    //设置填充物颜色
    CGContextSetFillColorWithColor(context, [[UIColor greenColor]CGColor]);
  
    
    //正方形
//    CGContextAddRect(context, CGRectMake(50, 0, 200, 200));
    
    //添加线段:线段的起始点如果不设置默认为上一次画笔计数的点
    //设置画笔起点
//    CGContextMoveToPoint(context, 100, 200);
//    CGContextAddLineToPoint(context, 320, 480);
    
    //弧线
    /*
    1.画布对象
     2.3.4 中心点x,y 以及半径
     5,6 开始角度  结束角度
     7  顺逆时针 (1逆)
     */
//    CGContextAddArc(context, 100, 100, 100, 0, M_PI_2, 1);
    //正方形 ===圆
//    CGContextAddEllipseInRect(context, CGRectMake(50, 50, 200, 200));
    //长方形  ===椭圆
    CGContextAddEllipseInRect(context, CGRectMake(50, 50, 200, 100));
    
    
    
    //绘制>>>读的是设置的线颜色
//    CGContextStrokePath(context);
    //设置填充物
    CGContextFillPath(context);
    
    
    //
    //绘制字体
//    [@"123456" drawAtPoint:CGPointMake(50, 250) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:26]}];
    
    //设置图片
//    UIImage *img =[UIImage imageNamed:@"head.png"];
    //旋转  平铺 和缩放 (起始点变了左下角1.1)
    //缩放
    /*
     缩放操作根据指定的x, y因子来改变坐标空间的大小，从而放大或缩小图像。x, y因子的大小决定了新的坐标空间是否比原始坐标空间大或者小。另外，通过指定x因子为负数，可以倒转x轴，同样可以指定y因子为负数来倒转y轴。通过调用CGContextScaleCTM函数来指定x, y缩放因子。图5-5显示了指定x因子为0.5，y因子为0.75后的缩放效果。
     
     */
//    CGContextScaleCTM(context, -1, 0.5);
    /*
     旋转变换根据指定的角度来移动坐标空间。我们调用CGContextRotateCTM函数来指定旋转角度(以弧度为单位)
     */
    //旋转
//    CGContextRotateCTM(context, M_PI_2);
    /*
     平移变换根据我们指定的x, y轴的值移动坐标系统的原点。我们通过调用CGContextTranslateCTM函数来修改每个点的x, y坐标值
     */
    //平移
//    CGContextTranslateCTM (context, 100, 50);
//    CGContextDrawImage(context, CGRectMake(50, 50, 200, 200), [img CGImage]);
    
    /*
     实际开发的过程中尽量不要使用以上这些方法来绘制内容和图片,因为用其绘制对应的内容和图片很耗费资源 uilabel UIimageView CALayer都是底层做了最好的优化和处理使用它们就可以了
     */
    
}
/*
 //画布
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
