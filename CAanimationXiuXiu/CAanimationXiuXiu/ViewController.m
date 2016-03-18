//
//  ViewController.m
//  CAanimationXiuXiu
//  仿支付宝咻咻动画
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()

@end

@implementation ViewController
{
    CADisplayLink *display;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//咻咻动画
-(void)xiuXiuAnimation
{
    CALayer *layer=[CALayer layer];
    layer.position=self.view.layer.position;//layer的position相当于View的center
    //谁小选谁    MIN(SCREENHEIGHT, SCREENWIDTH);
    //谁大选谁    MAX(SCREENWIDTH, SCREENHEIGHT);
    CGFloat wh=MIN(SCREENHEIGHT, SCREENWIDTH);
    layer.bounds=CGRectMake(0, 0, wh, wh);
    layer.cornerRadius=wh*0.5;
    [self.view.layer addSublayer:layer];
    
    CAAnimationGroup *group=[CAAnimationGroup animation];
    
    //缩放的基础动画
    CABasicAnimation *boundsAn=[CABasicAnimation animation];
    
    boundsAn.keyPath=@"transform.scale.xy";//改变layer的X和Y方向的缩放值
    boundsAn.fromValue=@0.0;
    boundsAn.toValue=@1.0;//原大小
    boundsAn.duration=2;
    boundsAn.removedOnCompletion=YES;
    
    //改变backgroundColor的基础动画
    CABasicAnimation *colorAn=[CABasicAnimation animation];
    colorAn.keyPath=@"backgroundColor";
    colorAn.fromValue=(id)[UIColor clearColor].CGColor;
    //获取随机颜色
    UIColor *color=[UIColor colorWithRed:arc4random()%100*0.01 green:arc4random()%100*0.01 blue:arc4random()%100*0.01 alpha:arc4random()%100*0.01];
    colorAn.toValue=(id)color.CGColor;
    colorAn.duration=2;
    colorAn.removedOnCompletion=YES;
    
    //改变透明度的关键帧动画
    CAKeyframeAnimation *opacityAn=[CAKeyframeAnimation animation];
    opacityAn.keyPath=@"opacity";//layer的opacity相当于View的alpha
    opacityAn.values=@[@0.5,@0.3,@0.0];
    opacityAn.tensionValues=@[@0.0,@0.5,@1];
    opacityAn.removedOnCompletion=YES;
    
    group.animations=@[boundsAn,opacityAn,colorAn];
    group.removedOnCompletion=YES;
    group.duration=2;
    [layer addAnimation:group forKey:nil];
    
    
    [self performSelector:@selector(removeLayer:) withObject:layer afterDelay:2];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self xiuXiuAnimation];
    /*
     文／sipdar（简书作者）
     原文链接：http://www.jianshu.com/p/c35a81c3b9eb
     著作权归作者所有，转载请联系作者获得授权，并标注“简书作者”。
     
     CADisplayLink是一个能让我们以和屏幕刷新率相同的频率将内容画到屏幕上的定时器。我们在应用中创建一个新的 CADisplayLink 对象，把它添加到一个runloop中，并给它提供一个 target 和selector 在屏幕刷新的时候调用。
     
     frameInterval属性是可读可写的NSInteger型值，标识间隔多少帧调用一次selector 方法，默认值是1，即每帧都调用一次。如果每帧都调用一次的话，对于iOS设备来说那刷新频率就是60HZ也就是每秒60次，如果将 frameInterval 设为2 那么就会两帧调用一次，也就是变成了每秒刷新30次。
     */
    display=[CADisplayLink displayLinkWithTarget:self selector:@selector(xiuXiuAnimation)];
    display.frameInterval=120;
    [display addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}
-(void)removeLayer:(CALayer *)layer
{

    [layer removeFromSuperlayer];//在父图层中移除
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view.layer removeAllAnimations];//移除所有的动画
    [display invalidate];//关闭、取消DisplayLink
    display=nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
