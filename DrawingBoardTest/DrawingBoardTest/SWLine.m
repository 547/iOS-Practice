//
//  SWLine.m
//  DrawingBoardTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SWLine.h"

@implementation SWLine
-(id)initWithLineColor:(UIColor *)color
{
    self=[super init];
    if (self) {
        _points=[[NSMutableArray alloc]init];
        _lineColor=color;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
