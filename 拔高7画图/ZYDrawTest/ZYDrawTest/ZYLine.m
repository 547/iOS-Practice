//
//  ZYLine.m
//  ZYDrawTest
//
//  Created by broncho on 16/3/22.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

//线段对象
#import "ZYLine.h"

@implementation ZYLine
-(id)init
{
    if (self =[super init])
    {
        _points =[[NSMutableArray alloc]initWithCapacity:0];
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
