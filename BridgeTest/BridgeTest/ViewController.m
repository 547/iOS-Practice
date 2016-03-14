//
//  ViewController.m
//  BridgeTest
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
//bridge==桥接，即将两种语言的对象相互转化

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self bridgeTest];
}
/*
 ARC下：
 1.dealloc不要调用super dealloc
 2.注意OC与C对象桥接的时候出现的问题
 3.arc下Block防止循环引用是用__weak修饰
 */

-(void)test{
    //    UIImageView *img =nil;
    //    //桥接
    //    [UIView beginAnimations:nil context:(__bridge void * _Nullable)(img)];
    
    
    //arc下OC与C对象桥接的时候需要注意:C语言不享受arc政策  需要手动管理
    /*
     java: 全自动
     ios : 半自动
     C   : 手动
     */
    //    People *p1 =[[People alloc]init];
    //    __bridge  单纯的转换  不会让引用计数增加
    //    p =(__bridge void *)(p1);
    //    __bridge_retained 引用计数+1
    //    p =(__bridge_retained void*)(p1);
    //    释放
    //    CFRelease(p);
    //提供C转OC的时候需要使用的方法  引用计数会-1
    //    p1 =(__bridge_transfer People*)(p);
    /*
     如若遇到OC对象与C对象桥接的时候需要注意的地方是C对象需要自己管理
     1.__bridge 引用计数不变
     2.__bridge_retained 引用计数+1
     3.__bridge_transfer 引用计数-1
     
     工作中建议大家如果遇到该方面的问题使用2和3
     
     */

}



-(void)bridgeTest
{
    //bridge==桥接，即将两种语言的对象相互转化
    People *p=[[People alloc]init];
    void *pc;//这是C语言的对象
    pc=(__bridge_retained void *)p;//arc下，C语言的对象是不会自动释放的,需要自己手动释放====用__bridge_retained void *将OC的对象转为C的对象，C的对象引用计数会加1
    People *p1=[[People alloc]init];
    p1=(__bridge_transfer People *)pc;//__bridge_transfer People *==C语言的对象转化为OC的对象，__bridge_transfer People *会使C语言的对象引用计数减1
    [p1 test];
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
