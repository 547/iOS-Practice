//
//  ViewController.m
//  NSPredicateTest
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**
 谓词
 */
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self predicateTestWithArray];
}

-(void)test
{
    NSString *abc=@"123";
    //判断字符串是否以xx开头
    BOOL yes=[abc hasPrefix:@"1"];
    NSLog(@"======%@",yes?@"是":@"不是");
    
    //判断某个字符串是否以xx结尾
    BOOL yes0=[abc hasSuffix:@"3"];
    NSLog(@"======%@",yes0?@"是":@"不是");
}
/**
 谓词：条件筛选
 用法接近于sqlite都是通过对应的语句进行筛选和查询
 创建谓词对象的时候为对象设置要查询的语句 依据语句才筛选
 */
/**字符串筛选*/
-(void)predicateTestWithString
{
  /**
   字符串本身:SELF
   例：@“SELF == ‘APPLE’"
   
   字符串相关：BEGINSWITH、ENDSWITH、CONTAINS
   例：@"name CONTAINS[cd] 'ang'"   //包含某个字符串
   @"name BEGINSWITH[c] 'sh'"     //以某个字符串开头
   @"name ENDSWITH[d] 'ang'"      //以某个字符串结束
   注:[c]不区分大小写[d]不区分发音符号即没有重音符号[cd]既不区分大小写，也不区分发音符号。
   */
    NSString *str=@"adhfrhie";
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"SELF BEGINSWITH[cd]%@",@"a"];//判断字符串是否以a开头===！！！！筛选语句不区分大小写
    BOOL yes=[pre evaluateWithObject:str];
    NSLog(@"======%@",yes?@"是":@"不是");
}
/**过滤数组*/
-(void)predicateTestWithArray{
    NSArray *cityAr=@[@"nanchang",@"shangrao",@"pinxiang",@"ganzhou",@"wuyuan"];
    NSString *str=@"an";
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"self contains[cd] %@",str];
    NSLog(@"%@",[cityAr filteredArrayUsingPredicate:pre]);
}
/**谓词结合正则表达式：
 判断是否是邮箱
 */
-(void)regularAndPredicateTest
{
    NSString *strRegex=@"[A-Z0-9a-z._%+-]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{1,5}";//正则表达式
    NSPredicate *pre=[NSPredicate predicateWithFormat:@"self matches %@",strRegex];//谓词
    BOOL yes=[pre evaluateWithObject:self.textF.text];
    NSLog(@"======%@",yes?@"是":@"不是");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self regularAndPredicateTest];
}
@end
