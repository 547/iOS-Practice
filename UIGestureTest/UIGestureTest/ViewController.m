//
//  ViewController.m
//  UIGestureTest
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UIView *view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
    [self screenEdgePanTest];
}
-(void)initUI
{
    view=[[UIView alloc]initWithFrame:CGRectMake(100, 260, 200, 150)];
    [self.view addSubview:view];
    view.backgroundColor=[UIColor redColor];
    [self tapGestureTest];
    [self swipTest];
    [self panTest];
    [self rotationTest];
    [self pinTest];
    [self longPressTest];
}
/*
 手势：UIGestureRecognizer(所有手势的父类)
 iOS手势分为：点击、长按、轻扫、捏合、旋转、拖动、屏幕边缘滑动
 开发的时候根据不同的需求选择对应的手势
 PS：手势是需要添加到UI空间上面去使用，只有绑定手势的空间才能捕捉到手势的响应
 */

#pragma mark===1.点按
-(void)tapGestureTest
{
    //点按==tap==敲击
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [view addGestureRecognizer:tap];
//    tap.delegate=self;//设置代理
}
-(void)tap:(UITapGestureRecognizer *)tap
{
    tap.view.backgroundColor=[UIColor greenColor];//获取手势的View
    
    NSLog(@"点按");
}

#pragma mark==== 2.轻扫滑动==PS:一个UISwipeGestureRecognizer对象只能绑定一个滑动方向，如果要让一个view响应多个滑动方向就要创建多少个UISwipeGestureRecognizer对象
-(void)swipTest
{
    UISwipeGestureRecognizer *swip=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    [view addGestureRecognizer:swip];
    //设置从哪个方向滑动
    swip.direction=UISwipeGestureRecognizerDirectionLeft;
    /*
     有些手势其实是互相关联的，例如 Tap 与 LongPress、Swipe与 Pan，或是 Tap 一次与Tap 兩次。当一個 UIView 同时添加兩个相关联的手势时，到底我这一下手指头按的要算是 Tap 还是 LongPress？如果照預设作法来看，只要「先滿足条件」的就会跳出并呼叫对应方法，举例来说，如果同时注册了 Pan 和 Swipe，只要手指头一移动就会触发 Pan 然后跳出，因而永远都不會发生 Swipe；单点与双点的情形也是一样，永远都只会触发单点，不會有双点。
     
     那么这个问题有解吗？答案是肯定的，UIGestureRecognizer 有个方法叫做requireGestureRecognizerToFail，他可以指定某一个 recognizer，即便自己已经滿足條件了，也不會立刻触发，会等到该指定的 recognizer 确定失败之后才触发。
     */
//    [swip requireGestureRecognizerToFail:<#(nonnull UIGestureRecognizer *)#>];

}
-(void)swip:(UISwipeGestureRecognizer *)sw
{
    sw.view.backgroundColor=[UIColor orangeColor];
    NSLog(@"左滑");
}
#pragma mark===3.拖拽
-(void)panTest
{
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [view addGestureRecognizer:pan];
}
-(void)pan:(UIPanGestureRecognizer *)pa
{
    if (pa.state==UIGestureRecognizerStateChanged) {
       CGPoint endPoint= [pa locationInView:[pa.view superview]];//获取拖拽的点在加了拖拽手势的View的父视图上的坐标

        view.center=endPoint;//将获取到的坐标点作为加了拖拽手势的View的中心点，是view可以随着手指移动
    }
}
#pragma mark===4.旋转
-(void)rotationTest
{
    UIRotationGestureRecognizer *rotation=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    [view addGestureRecognizer:rotation];
}
-(void)rotation:(UIRotationGestureRecognizer *)ro
{
       if (ro.state==UIGestureRecognizerStateChanged) {
       ro.view.transform= CGAffineTransformMakeRotation(ro.rotation);//添加了旋转手势的VIew跟着手指的旋转而旋转
    }
    
}
#pragma mark===5.捏合
-(void)pinTest{
    UIPinchGestureRecognizer *pin=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pin:)];
    [view addGestureRecognizer:pin];

}
-(void)pin:(UIPinchGestureRecognizer *)pin
{
    if (pin.state==UIGestureRecognizerStateChanged) {
        pin.view.transform=CGAffineTransformMakeScale(pin.scale, pin.scale);//根据手势的捏合比例让视图缩放
    }
}
#pragma mark===6.长按
-(void)longPressTest
{
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration=1;//设置按压最小时间
    [view addGestureRecognizer:longPress];
}
-(void)longPress:(UILongPressGestureRecognizer *)longP
{
    longP.view.backgroundColor=[UIColor purpleColor];
    [self showMenu:longP];
    
}
#pragma mark===7.屏幕边缘滑动
-(void)screenEdgePanTest
{
    UIScreenEdgePanGestureRecognizer *screenEdgePan=[[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdgePan:)];
    screenEdgePan.edges=UIRectEdgeLeft;//设置可以滑动的屏幕边缘
    [self.view addGestureRecognizer:screenEdgePan];
}
-(void)screenEdgePan:(UIScreenEdgePanGestureRecognizer *)screen
{
    NSLog(@"screenEdgePan");
}
#pragma mark==actionSheet
-(void)showActionSheet
{
    UIAlertController *alter=[UIAlertController alertControllerWithTitle:@"长按" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alter addAction:action];
    
    [self presentViewController:alter animated:YES completion:nil];

}
#pragma mark==menu
-(void)showMenu:(UILongPressGestureRecognizer *)longP
{
   CGPoint pressPoint = [longP locationInView:longP.view];
    UIMenuController *menu=[UIMenuController sharedMenuController];
    
    //PS:UIMenuItem绑定的方法传的参数是UIMenuController
     UIMenuItem *item1=[[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(menuClick:)];
     UIMenuItem *item2=[[UIMenuItem alloc]initWithTitle:@"剪切" action:@selector(menuClick:)];
     UIMenuItem *item3=[[UIMenuItem alloc]initWithTitle:@"搜索" action:@selector(menuClick:)];
     UIMenuItem *item4=[[UIMenuItem alloc]initWithTitle:@"分享" action:@selector(menuClick:)];
        
       menu.menuItems=@[item1,item2,item3,item4];
    
    [menu setTargetRect:CGRectMake(pressPoint.x, pressPoint.y, 100, 30) inView:view];
    [menu setMenuVisible:YES animated:YES];
}
-(void)menuClick:(id)item
{
    NSLog(@"%d",[item isKindOfClass:[UIMenuController class]]); //PS:UIMenuItem绑定的方法传的参数是UIMenuController
    NSLog(@"45456456456");
//    NSLog(@"%@",item.title);
}
//PS：copy和cut这两个方法是系统为Menuitem绑定的方法，在为menuitem绑定方法的时候要记得不要跟着两个方法重名
//-(void)copy:(id)sender
//{
//
//}
//-(void)cut:(id)sender
//{
//}
//PS：要想显示UIMenuController：canBecomeFirstResponder。否则不会显示
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
@end
