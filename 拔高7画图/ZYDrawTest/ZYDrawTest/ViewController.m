//
//  ViewController.m
//  ZYDrawTest
//
//  Created by broncho on 16/3/22.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ViewController.h"
#import "ZYView1.h"
#import "ZYView2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //画>>>>K线图,比例图,树状图
    //利用ui控件的drawRect方法  添加对应的内容
//    ZYView1 *vi1_ =[[ZYView1 alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
//    vi1_.backgroundColor =[UIColor whiteColor];
//    self.view =vi1_;
    
    
  
    
    ZYView2 *vi1_ =[[ZYView2 alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    vi1_.backgroundColor =[UIColor whiteColor];
    self.view =vi1_;
    
    UISegmentedControl *_control =[[UISegmentedControl alloc]initWithItems:@[@"红色",@"绿色",@"黑色"]];
    _control.selectedSegmentIndex =0;
    [_control addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
    _control.frame =CGRectMake(20, 30, 280, 44);
    [vi1_ addSubview:_control];
    //撤销
    UIButton *undo =[UIButton buttonWithType:UIButtonTypeCustom];
    undo.frame =CGRectMake(20, 84, 50, 40);
    [undo setTitle:@"撤销" forState:UIControlStateNormal];
    undo.backgroundColor =[UIColor orangeColor];
    [undo addTarget:self action:@selector(undoClick:) forControlEvents:UIControlEventTouchUpInside];
    [vi1_ addSubview:undo];
    
    
    //添加保存图片按钮
    UIButton *saveBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame =CGRectMake(80, 84, 150, 40);
    [saveBtn setTitle:@"保存相册" forState:UIControlStateNormal];
    saveBtn.backgroundColor =[UIColor orangeColor];
    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [vi1_ addSubview:saveBtn];
    
    
    
    
    colors =[[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor greenColor], [UIColor blackColor],nil];
    
    
    
    //手势
    UIPanGestureRecognizer *gesture =[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [vi1_ addGestureRecognizer:gesture];

}
//保存相册
-(void)saveClick:(UIButton *)sender
{
    //保存相册
    UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error)
    {
        NSLog(@"成功");
    }
    else
    {
        NSLog(@"失败");
    }
}
-(void)undoClick:(UIButton *)sender
{
    //从当前view2的lines数组里面找出来最后一个元素  删除
    ZYView2 *vi2 =(ZYView2 *)self.view;
    if (vi2.lineArray.count !=0)
    {
        [vi2.lineArray removeLastObject];
        
        [vi2 setNeedsDisplay];
    }
}
-(void)changeColor:(UISegmentedControl *)control
{
    selectIndex =control.selectedSegmentIndex;
}
-(void)panGesture:(UIPanGestureRecognizer *)gesture
{
    ZYView2 *vi2 =(ZYView2 *)gesture.view;
    
    //获取对应的point点
    CGPoint point =[gesture locationInView:gesture.view];
    
    NSValue *value =[NSValue valueWithCGPoint:point];
    
    //收集点(如何确保每一次操作生成一条线)
    if (gesture.state ==UIGestureRecognizerStateBegan)
    {
        //开始滑动 证明有新的线段要创建出来
        //装线段对象 (考虑到后期的功能会持续增加在这里创建专属的线段类要好一些)
        line =[[ZYLine alloc]init];
//        NSLog(@"创建线段");
        line.color =colors[selectIndex];
        [vi2.lineArray addObject:line];
        
    }
    //装point对象
//     NSLog(@"装point点");
    [line.points addObject:value];
    
    [vi2 setNeedsDisplay];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
