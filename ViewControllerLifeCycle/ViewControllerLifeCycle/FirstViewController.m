//
//  FirstViewController.m
//  ViewControllerLifeCycle
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
//最先调用
-(id)init{
    if (self==[super init]) {
        NSLog(@"=====%@",self.view);
        //不要在此处创建控件，因为controller对象出来了，但是view还没有创建出来
    }
    return self;
}
//viewDidLoad是在VIewcontrol需要用到VIew的时候调用==如果当前视图控制器能从viewdidload找到VIew就直接用（return）==所以之调用一次，如果没有找到系统就会调用loadview这个方法获取view
-(void)loadView
{
    /*
     这个方法的作用：主要是为VIewcontrol提供对应的VIew
     如果重写loadview，就必须提供对应的uiview对象给controller，不然loadView和viewDidLoad会陷入死循环
     */
    
    UIView *vie=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    vie.backgroundColor=[UIColor blueColor];
    self.view=vie;
    

}
//只调用一次
- (void)viewDidLoad {
    /*
     重写loadview方法，就可以不需要[super viewDidLoad]，因为重写loadview方法意味着不需要系统的VIew
     */
//    [super viewDidLoad];
    NSLog(@"----+++++%@",self.view.window);
    /*
     在这里去对self.view进行动画之类的操作是完成不了的，因为此时VIew所依赖的Windows还没有构建完成
     */
    
    /*
     构建VIew对应的控件为view设置对应
     */
}
//界面每次渲染的时候都会调用==一般用于界面传值
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"----+++++%@",self.view.window);
}
//处理一些视图动画效果
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"----+++++%@",self.view.window);
}
//试图将要消失
-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"----+++++%@",self.view.window);
}
//视图已经消失
-(void)viewDidDisappear:(BOOL)animated
{

}
//收到内存警告
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//当前类出现内存警告的时候调用该方法，在此出会释放系统内部构建的用于当前视图的一些对象，PS：一定不要在此处释放自己创建的内存

}
//-(void)viewDidUnload
//{
///*
// 如果当前应用程序出现内存警告，那么系统会把一些当前还没有展示到主界面，VIewcontrol对象通过调用viewDidUnload方法释放创建出来的对象内存，这个方法不要重写
// */
//}






























/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
