//
//  ViewController.m
//  ARCTest
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
/*
 ARC===iOS 5.0（手机版本）后出来的===编译特性
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*
     因为self.p1使用weak描述的弱引用指针，编译特性把它定性为只是使用别人的people对象而不是参与管理，所以当people对象清空的时候，系统也会自动把self.p1（weak）清空，防止造成野指针
     */
    self.people =[[People alloc]init];
//    self.p2=self.people;
//    self.p1=self.people;
//    self.people=nil;
//    NSLog(@"=======%@",self.p1);//p1==weak==输出null
//    NSLog(@"=======%@",self.p2);//p2==strong==输出<People: 0x7fc219c3cba0>
//    self.p3=self.people;
//    self.people=nil;
//    NSLog(@"------%@",self.p3);
    
    
    //局部变量==arc情况下，当前方法执行完毕后自动释放
//    People *peo=[[People alloc]init];
//    [peo test];
    
    
    //局部创建的对象指针类型有strong、weak、unsafe_unretained变成了__strong、__weak、__unsafe_unretained
    __strong NSString *str1=[[NSString alloc]initWithUTF8String:"12121"];
    __weak NSString *str2=str1;
    //因为str1已经清空，str2在weak的知道下也已经清空，所以str3有值也一定是野指针
    __unsafe_unretained NSString *str3=str2;
    str1=nil;//清空
        NSLog(@"str3==%@",str3);
        NSLog(@"str2==%@",str2);
        NSLog(@"str1==%@",str1);
    
    
    NSMutableArray *arr=[[NSMutableArray alloc]initWithObjects:@"545",@"5747", @"1221", nil];
    NSLog(@"arr----%@,str3==%@",arr,str3);
    
    
    
}
-(void)dealloc
{
//在arc的情况下一定不要调用父类的dealloc的方法
   
    //通知、描述、kvo、全局变量
    NSLog(@"%s",__FUNCTION__);
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
