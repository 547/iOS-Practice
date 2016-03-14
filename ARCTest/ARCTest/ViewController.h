//
//  ViewController.h
//  ARCTest
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "People.h"
@interface ViewController : UIViewController
/*
 ARC下的描述、 MRC下的描述的区别


 
 MRC下的描述==retain
 
 
 
 ARC===strong（强引用）、weak（弱引用）构成arc下的两种指针描述的类型
 strong==强引用描述的对象放在堆上；
 weak==弱引用描述的对象放到栈上；
 
 堆：放到堆上的对象需要程序员自己来管理（strong）
 栈：放在栈上的对象系统帮助管理（weak）
 
 ARC==用retain时会自动转成strong
 weak==只是单纯地使用某个对象（获取、引用而不是创建）的时候用弱引用，只有使用权没有管理权
 */
@property(nonatomic,strong)People *people;
@property(nonatomic,weak)People *p1;
@property(nonatomic,strong)People *p2;
//arc下写assign系统自动转成unsafe_unretained==PS:unsafe_unretained描述基本数据类型的时候使用，千万不要用来描述对象，否则会造成野指针
@property(nonatomic,unsafe_unretained)People *p3;
//arc\mrc都是copy
@property(nonatomic,copy)People *p4;
@end

