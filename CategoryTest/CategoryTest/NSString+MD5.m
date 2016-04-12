//
//  NSString+MD5.m
//  CategoryTest
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**
PS：类别不用创建对象调用，直接用被扩类的对象调用
 category===种类，分类===对原有类的扩充，子类也可以使用
 类别是轻量级扩展，继承是重量级扩展
 类别是在原有的基础上扩展新的方法，PS：尽量不要扩展属性，也不要覆盖原有的方法
 **/

/**
 类别的优点：
 1.对原有类的扩充；
 2.方法的私有化；
 3.分散类的实现；
 **/
/*
 系统方法分散类的实现
 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 
 */
#import "NSString+MD5.h"

/**
 @implementation NSString (MD5)
                    |       |
                被扩展的类 扩展的功能==file名
 **/
@implementation NSString (MD5)

-(void)MD5
{
    NSLog(@"%s",__FUNCTION__);
    
}
+(void)Base64
{
    NSLog(@"%s",__FUNCTION__);
}

-(NSString *)trim
{
    //只能去首尾的空格[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]
//    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    //替换字符的方法 参数1：要替换的字符 参数2：要替换成的字符
   return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}
-(NSString *)getFilePath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

@end
