//
//  ViewController.m
//  自定义视图切换动画
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    
}
//展示VIewcontrol
-(void)showViewControl{
    SecondViewController *second=[[SecondViewController alloc]init];
    [self presentViewController:second animated:NO completion:nil];

}
-(void)mainContent
{
    //damping参数代表弹性阻尼，随着阻尼值越来越接近0.0，动画的弹性效果会越来越明显，而如果设置阻尼值为1.0，则视图动画不会有弹性效果——视图滑动时会直接减速到0并立刻停止，不会有弹簧类的拉伸效果。
    
    //velocity参数代表弹性修正速度，它表示视图在弹跳时恢复原位的速度，例如，如果在动画中视图被拉伸的最大距离是200像素，你想让视图以100像素每秒的速度恢复原位，那么就设置velocity的值为0.5。（译者：建议大家看看源代码，代码中damping设置为0.8不够明显，你可以将damping调为0.1，然后慢慢调整velocity看看效果）
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.1 initialSpringVelocity:0.3 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.view.alpha=0.5;
    } completion:^(BOOL finished) {
        [self showViewControl];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
[self mainContent];
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
