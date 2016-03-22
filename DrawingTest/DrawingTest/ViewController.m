//
//  ViewController.m
//  DrawingTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "SWView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawTest];
}

/*
 画图：K线图、比例图，树状图，
 利用UI控件的drawRect方法，添加对应的内容==核心
 
 */
-(void)drawTest
{
    SWView *view=[[SWView alloc]initWithFrame:self.view.frame];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
