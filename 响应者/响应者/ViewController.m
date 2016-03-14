//
//  ViewController.m
//  响应者
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
//扩展===相当于New File一个新的类
//一个类里面如果拓展了多个类的话一定要注意去写类的实现
@interface MyView : UIView
//.h

@end
@implementation MyView

//.m
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    NSLog(@"--------%ld",self.tag);
}
@end


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self responder];
}
/*
 只要是继承自UIReaponder的类都具有响应的特性
 每触发一次响应都会根据响应事件传递给下一层的响应者直至完成该事件
 每一个响应者都是一个对应的事件循环这种循环叫做响应者链
 */
//响应者
-(void)responder{
    MyView *view=[[MyView alloc]initWithFrame:CGRectMake(50, 50, 200, 300)];
    view.backgroundColor=[UIColor redColor];
    view.tag=100;
    [self.view addSubview:view];
    MyView *view1=[[MyView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
    view1.backgroundColor=[UIColor whiteColor];
    view1.tag=200;
    [view addSubview:view1];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    NSLog(@"1111=====%@",[self nextResponder]);


}
- (void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(nullable UIPressesEvent *)event
{
    NSLog(@"hjsjhasj");
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
