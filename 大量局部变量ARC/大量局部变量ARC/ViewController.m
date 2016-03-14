//
//  ViewController.m
//  大量局部变量ARC
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ARC下创建大量对象的时候怎么处理
    for (int i=0; i<1000; i++) {
        //由于创建的对象过多，系统在释放的时候可能会出现内存泄露的问题====因为系统自动将对象方入的自动释放池可能不是一个自动释放池，不在同一个自动释放池内就会导致释放的时间不一致，就会造成内存释放，解决这种可能的方法就是人为地将对象放入一个自动释放池内如下：
        
        @autoreleasepool {
            People *p=[[People alloc]init];
        }
        
    }
}














- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
