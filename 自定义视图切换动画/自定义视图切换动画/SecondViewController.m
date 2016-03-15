//
//  SecondViewController.m
//  自定义视图切换动画
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor yellowColor];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissSelf];
}
//dismiss自己
-(void)dismissSelf
{
    [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        [self mainContent];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
//主要内容==动画（帧）
-(void)mainContent
{
    [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.15 animations:^{
        //顺时针旋转90度
        self.view.transform =CGAffineTransformMakeRotation(M_PI*-1.5);
    }];
    [UIView addKeyframeWithRelativeStartTime:0.15 relativeDuration:0.1 animations:^{
        //180度
        self.view.transform =CGAffineTransformMakeRotation(M_PI*1.0);
    }];
    [UIView addKeyframeWithRelativeStartTime:0.25 relativeDuration:0.2 animations:^{
        //摆过中点，225度
        self.view.transform=CGAffineTransformMakeRotation(M_PI*5/4);
        
    }];
    [UIView addKeyframeWithRelativeStartTime:0.45 relativeDuration:0.2 animations:^{
        //再摆回来，140度
        self.view.transform=CGAffineTransformMakeRotation(M_PI*0.8);
        
    }];
    [UIView addKeyframeWithRelativeStartTime:0.65 relativeDuration:0.35 animations:^{
        //旋转后掉落
        //最后一步，视图淡化并消失
        CGAffineTransform shift=CGAffineTransformMakeTranslation(180.0, 0.0);
        CGAffineTransform rotate=CGAffineTransformMakeRotation(M_PI*0.3);
        self.view.transform=CGAffineTransformConcat(shift, rotate);
        self.view.alpha=0;
    }];
    
    
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
