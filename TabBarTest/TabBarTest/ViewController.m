//
//  ViewController.m
//  TabBarTest
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "FristViewController.h"
#import "NextViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    //和导航结合使用
    
    //系统上的tabbar上的item最多展示5个，超过就会以more的形式展示
    UITabBarController *tab=[[UITabBarController alloc]init];
    FristViewController *frist=[[FristViewController alloc]init];
    frist.view.backgroundColor=[UIColor redColor];
    frist.tabBarItem.title=@"frist";
    
    UINavigationController *fNa=[[UINavigationController alloc]initWithRootViewController:frist];
    
    //对图片大小有要求==分模拟器，如果传入的图过大，图会失真
//    frist.tabBarItem.image
    NextViewController *next=[[NextViewController alloc]init];
    next.tabBarItem.title=@"next";
    next.view.backgroundColor=[UIColor blueColor];
 UINavigationController *nNa=[[UINavigationController alloc]initWithRootViewController:next];
    //装对应的Viewcontroller
    tab.viewControllers=@[fNa,nNa];

   AppDelegate *app= [UIApplication sharedApplication].delegate;
    app.window.rootViewController=tab;
    
//    [[UIApplication sharedApplication].delegate window];
//   UIWindow *win= [UIApplication sharedApplication].keyWindow.window;
//   UIWindow *win1= [[UIApplication sharedApplication].windows objectAtIndex:0] ;
//   UIWindow *win2 = [UIApplication sharedApplication].windows[0];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
