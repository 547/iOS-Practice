//
//  SWView.m
//  DrawingBoardTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SWView.h"
#import "SWLine.h"
@implementation SWView
-(id)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.lines=[[NSMutableArray alloc]init];
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    //创建画板
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //划线
    [self.lines enumerateObjectsUsingBlock:^(SWLine *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //设置画笔的颜色
         CGContextSetStrokeColorWithColor(context, [obj.lineColor  CGColor]);
        //设置画笔的粗细
        CGContextSetLineWidth(context, obj.lineWidth);
        [obj.points enumerateObjectsUsingBlock:^(NSValue   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGPoint point=[obj CGPointValue];
            if (idx==0) {
                CGContextMoveToPoint(context, point.x, point.y);
            }
            CGContextAddLineToPoint(context, point.x, point.y);
        }];
        //绘制
        CGContextStrokePath(context);

    }];

}
@end
