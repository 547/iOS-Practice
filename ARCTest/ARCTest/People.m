//
//  People.m
//  ARCTest
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "People.h"

@implementation People
-(void)test
{
    NSLog(@"-----%s",__FUNCTION__);
    NSLog(@"======%@",self);
}
-(void)dealloc
{
    NSLog(@"----%s",__FUNCTION__);
}
@end
