//
//  ViewController.m
//  HuiHuaTest
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}
-(void)initUI
{
    self.huaBan.layer.cornerRadius=6;
    self.huaBan.layer.borderColor=[UIColor blackColor].CGColor;
    self.huaBan.layer.borderWidth=1.0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//画一个矩形
- (IBAction)juXing:(UIButton *)sender {
    
   CAShapeLayer *layer = [CAShapeLayer layer];
    
    layer.frame=CGRectMake(10, 10, 150, 90);
    layer.cornerRadius=6;
    layer.backgroundColor=[UIColor blueColor].CGColor;
    /**
     边框颜色\填充颜色
     这两个属性只能配合贝塞尔曲线一起使用，不然不会显示
     **/
//    layer.strokeColor=[UIColor blueColor].CGColor;//设置边框颜色=====
//    layer.fillColor=[UIColor yellowColor].CGColor;//设置填充颜色
    [self.huaBan.layer addSublayer:layer];
    
}
//画一个圆形
- (IBAction)yuanXing:(UIButton *)sender {
    
        CAShapeLayer *layer=  [CAShapeLayer layer];
//    UIBezierPath *path=[UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 20, 150, 150) cornerRadius:70];//指定角度半径画圆
    UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:50 startAngle:0.0 endAngle:M_PI*2 clockwise:NO];//M_PI==3.14159==画圆可以想到2M_PIR===2*M_PI==360度===clockwise==是否闭合
        layer.path=path.CGPath;
        layer.fillColor=[UIColor clearColor].CGColor;//填充颜色
        layer.strokeColor=[UIColor blueColor].CGColor;//边框颜色
        [self.huaBan.layer addSublayer:layer];

    CAShapeLayer *la=[CAShapeLayer layer];
    UIBezierPath *pa=[UIBezierPath bezierPathWithArcCenter:CGPointMake(SCREENWIDTH-5-100, 100) radius:50 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    la.path=pa.CGPath;
    la.fillColor=[UIColor clearColor].CGColor;
    la.strokeColor=[UIColor redColor].CGColor;
    [self.huaBan.layer addSublayer:la];
    
    
}
//画曲线
- (IBAction)huaQuXian:(UIButton *)sender {
    
    CGPoint statrPoint=CGPointMake(50, 300);
    CGPoint endPoint=CGPointMake(300, 300);
    CGPoint controlPoint=CGPointMake(170, 200);
    
    CAShapeLayer *layer1=[CAShapeLayer layer];
    layer1.frame=CGRectMake(statrPoint.x, statrPoint.y, 5, 5);
    layer1.backgroundColor=[UIColor redColor].CGColor;
    
    CAShapeLayer *layer2=[CAShapeLayer layer];
    layer2.frame=CGRectMake(endPoint.x, endPoint.y, 5, 5);
    layer2.backgroundColor=[UIColor redColor].CGColor;
    
    CAShapeLayer *layer3=[CAShapeLayer layer];
    layer3.frame=CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer3.backgroundColor=[UIColor redColor].CGColor;
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    UIBezierPath *path=[[UIBezierPath alloc]init];
    [path moveToPoint:statrPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];//Curve==曲线 第一个参数：终点 第二个参数：控制点====画出的曲线是往控制点的方向凸出的，并且凸出的幅度是起点和终点的连线到控制点的垂直距离的一半
    layer.path=path.CGPath;
    layer.fillColor=[UIColor clearColor].CGColor;
    layer.strokeColor=[UIColor blackColor].CGColor;
    [self.view.layer addSublayer:layer];
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
}
//画双弧度曲线
- (IBAction)shuangHuDuQuXian:(UIButton *)sender {
    
    
    
}
@end
