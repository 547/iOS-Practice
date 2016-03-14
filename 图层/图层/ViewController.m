//
//  ViewController.m
//  图层
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self layer];
}
//PS:优化TableVIew的方法：在tableVIew的时候如果不考虑点击事件，可以直接使用CAlayer布局，这样TableView不卡，节省内存
/*
 CAlayer继承自NSobject，所以不会响应事件
 图层layer，一个UIVIew至少有一个layer（图层）
 uiview 负责提供和展示对应的内容
 CAlayer负责渲染对应的视图
 
 很多属性其实并不是UIVIew的而不是使用的CALayer的
 */

-(void)layer{
    
    CALayer *layer=[[CALayer alloc]init];
    [self.view.layer addSublayer:layer];//添加子layer
    layer.bounds=CGRectMake(0, 0, 200, 200);
//    layer.backgroundColor=[UIColor redColor].CGColor;
    layer.position=CGPointMake(200, 300);
//    layer.transform=CATransform3DMakeRotation(M_1_PI, 20, 50, 30);
    
    //填充
//    layer.contents=(__bridge id _Nullable)([UIImage imageNamed:@"5.png"].CGImage);
    layer.doubleSided=YES;
    //如果当前知道具体的图层数，可以指定当前图层在整个图层中的位置
    //使用CAlAyer可以使用它的两个子类来完成对应的渲染和展示文字的效果
    
    //渲染的时候最好用bounds和position
    //渲染==可以利用colors这个属性做渐变效果
    CAGradientLayer *gradient=[[CAGradientLayer alloc]init];
    gradient.frame=layer.bounds;
    struct CGColor *red=[UIColor greenColor].CGColor;
    struct CGColor *blue=[UIColor blueColor].CGColor;
    NSArray *color=[[NSArray alloc]initWithObjects:(__bridge id _Nonnull)(red),blue,nil];
    gradient.colors=color;
//    gradient.locations=@[[NSNumber numberWithFloat:0.1],[NSNumber numberWithFloat:0.1]];
    //最大值为1，最小值为0
    gradient.startPoint=CGPointMake(0, 0);
    gradient.endPoint=CGPointMake(0.5, 1);
    [layer addSublayer:gradient];
    
    //文字图层
    CATextLayer *textL=[[CATextLayer alloc]init];
    //    textL.backgroundColor=[UIColor yellowColor].CGColor;
    textL.foregroundColor=[UIColor redColor].CGColor;//设置字的颜色
    textL.truncationMode=@"center";
    textL.frame=CGRectMake(10, 20, 100, 30);
    textL.string=@"454545";
    [layer addSublayer:textL];

    

}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
