//
//  ZYView2.m
//  ZYDrawTest
//
//  Created by broncho on 16/3/22.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYView2.h"
#import "ZYLine.h"
@implementation ZYView2
-(id)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame])
    {
        self.lineArray =[[NSMutableArray alloc]initWithCapacity:0];
        NSLog(@"----%@",self.lineArray);
    }
    return self;
}
//-(id)init
//{
//    if (self =[super init])
//    {
//        //装线段的数组
//   
//    }
//    return self;
//}
- (void)drawRect:(CGRect)rect {
    
    //划线
    CGContextRef contextRef =UIGraphicsGetCurrentContext();
    //遍历
    [_lineArray enumerateObjectsUsingBlock:^(ZYLine *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
    CGContextSetStrokeColorWithColor(contextRef, [obj.color CGColor]);
        
        CGContextSetLineWidth(contextRef, 3);
        
        //帮当前数组中已经存在的线段找出来
        [obj.points enumerateObjectsUsingBlock:^(NSValue *  _Nonnull value, NSUInteger idx, BOOL * _Nonnull stop) {
            //这里能把所有的point点找出来
            
            //设置对应的属性 >>线段
            //?第一个起点point
            CGPoint point =[value CGPointValue];
            if (idx ==0)
            {
                //起点
            CGContextMoveToPoint(contextRef, point.x, point.y);
            }else
            {
            CGContextAddLineToPoint(contextRef, point.x, point.y);
            }
            
        }];
        
        //设置线
        CGContextStrokePath(contextRef);
    }];
    
    
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
