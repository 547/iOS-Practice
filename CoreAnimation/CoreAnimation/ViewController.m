//
//  ViewController.m
//  CoreAnimation
//  核心动画
//  Created by mac on 16/3/18.
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
    [self coreAnimation];
}
#pragma mask===结论：开发中如果遇到
/*
 基础动画API：满足常规的动画需求
 核心动画：提供更加绚丽的动画效果
 QuartzCore:提供动画需要的API
 CAAnimation：标准的基础动画（核心动画的普通动画），是总类（父类）提供四个不同效果的子类：
 CABasicAnimation==基础动画（指定某个对应的属性来做动画）
 CAKeyframeAnimation==关键帧动画（可以把某个动画动作以帧的形式展示）
 CATransition==旋转、平移、缩放
 CAAnimationGroup==动画组（多个动画装入一个动画组中展示）
 
 CAMediaTiming==提供动画底层处理的逻辑
 CAPropertyAnimation是基础动画和关键帧动画的父类
 */

-(void)coreAnimation{
    view=[[UIView alloc]initWithFrame:CGRectMake(200, 200, 50, 50)];
    view.backgroundColor=[UIColor greenColor];
    [self.view addSubview:view];
   
}
#pragma mark==基础动画CABasicAnimation
//PS:所有的动画效果都是以锚点为基准点来做动画
//PS:CABasicAnimation可以对某一个属性的某个值的变化做动画如：bounds.size.width
-(void)baseAnimationChangePosition
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
    
    base.keyPath=@"position";//属性字符串
    //设置开始、结束的值
    /*
     结构体转成NSvalue
     */
    base.fromValue=[NSValue valueWithCGPoint:CGPointMake(0, 0)];
    base.toValue=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
//    base.delegate=self;
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
-(void)baseAnimationChangeBounds
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
    
    base.keyPath=@"bounds";//属性字符串
    //设置开始、结束的值
    /*
     结构体转成NSvalue
     */
    base.fromValue=[NSValue valueWithCGRect:view.bounds];
    base.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
    //    base.delegate=self;
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
#pragma mark==CABasicAnimation不可以改变frame
-(void)baseAnimationChangeFrame
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
   
    base.keyPath=@"frame";//属性字符串
    //设置开始、结束的值
    /*
     结构体转成NSvalue
     */
    base.fromValue=[NSValue valueWithCGRect:CGRectMake(200, 200, 50, 50)];
    base.toValue=[NSValue valueWithCGRect:CGRectMake(300, 450, 100, 200)];
    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
    //    base.delegate=self;
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
-(void)baseAnimationChangeBackgroundColor
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
    
    base.keyPath=@"backgroundColor";//属性字符串
    //设置开始、结束的值
    /*
     结构体转成NSvalue
     */
    base.fromValue=(id)[[UIColor greenColor]CGColor];
    base.toValue=(id)[[UIColor redColor]CGColor];
    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
    //    base.delegate=self;
    
    
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
#pragma mark===旋转
-(void)baseAnimationChangeTransformXZ
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
    
    //旋转、平移、缩放都是transform属性的只要改变值就行
    
    base.keyPath=@"transform";//view.layer.transform
    //角度，X,Y,Z轴
    base.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 1, 0, 1)];
    base.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*5/4, 1, 0, 1)];
    

    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
    //    base.delegate=self;
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
#pragma mark===缩放
-(void)baseAnimationChangeTransformSF
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
    
    //旋转、平移、缩放都是transform属性的只要改变值就行
    
    base.keyPath=@"transform";//view.layer.transform
    //Scale比例，缩放比例（x,y,z）
    base.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(0, 0, 0)];
    base.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 0.5, 1)];
    
    
    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
    //    base.delegate=self;
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
#pragma mark===平移
-(void)baseAnimationChangeTransformPY
{
    CABasicAnimation *base=[CABasicAnimation animation];
    //基础动画是为指定某一个属性进行动画效果，核心的话的一个必要条件就是必须得是CALayer的某一个属性否则无效
    
    //旋转、平移、缩放都是transform属性的只要改变值就行
    
    base.keyPath=@"transform";//view.layer.transform
    //Translation比例，位移（x,y,z）
    base.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)];
    base.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 50, 30)];
    
    
    //动画完成后是否把动画移除
    base.removedOnCompletion=NO;
    //设置对应的动画fillModel
    base.fillMode=kCAFillModeForwards;
    //动画时间
    base.duration=2;
    //执行次数
    base.repeatCount=2;
    //设置代理
    //    base.delegate=self;
    //添加==所有的核心动画对当前空间的图层都只是一个复制，在做动画的时候都是拿着复制的这个图层做动画
    [view.layer addAnimation:base forKey:nil];
}
#pragma mark==关键帧动画CAKeyframeAnimation
//动画的原理是把每一个动画的效果设定对应的时间来完成
-(void)keyframeAnimation
{
    CAKeyframeAnimation *key=[CAKeyframeAnimation animation];
//    view.layer.transform.rotation
    key.keyPath=@"transform.rotation.y";
    key.values=@[@(0),@(20),@(50),@(10),@(90)];
    //每一个动画时间对应上面动画值
    key.keyTimes=@[@(0.1),@(0.5),@(0.2),@(0.9)];
    key.duration=1.7;
    key.fillMode=kCAFillModeForwards;
    [view.layer addAnimation:key forKey:nil];
}
#pragma mark==动画组CAAnimationGroup
//动画组就是把几个基础动画方法到一个组里面展示
-(void)animationGroup{
    CAAnimationGroup *group=[CAAnimationGroup animation];//创建一个动画组实例对象
    
    
    CABasicAnimation *base0=[CABasicAnimation animation];
    base0.keyPath=@"bounds";//属性字符串
    base0.fromValue=[NSValue valueWithCGRect:view.bounds];
    base0.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
   
    //动画时间
    base0.duration=2;

    
    CABasicAnimation *base1=[CABasicAnimation animation];
    base1.keyPath=@"transform";//view.layer.transform
    //Translation比例，位移（x,y,z）
    base1.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0)];
    base1.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeTranslation(100, 50, 30)];
    base1.duration=2;
    
    CABasicAnimation *base2=[CABasicAnimation animation];
    base2.keyPath=@"transform";//view.layer.transform
    //角度，X,Y,Z轴
    base2.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 1, 0, 1)];
    base2.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI*1, 1, 0, 1)];
    base2.duration=2;
    
    CABasicAnimation *base3=[CABasicAnimation animation];
    base3.keyPath=@"backgroundColor";//属性字符串
    base3.fromValue=(id)[[UIColor greenColor]CGColor];
    base3.toValue=(id)[[UIColor redColor]CGColor];
    //动画时间
    base3.duration=2;

    
    group.animations=@[base0,base1,base2,base3];//将基础动画加入到动画组中
    group.duration=2;
    [view.layer addAnimation:group forKey:nil];//图层添加动画组
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self animationGroup];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
