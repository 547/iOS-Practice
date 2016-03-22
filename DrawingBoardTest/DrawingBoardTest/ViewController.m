//
//  ViewController.m
//  DrawingBoardTest
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "SWView.h"
#import "SWLine.h"
@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *points;
    SWView *view;
    SWLine *line;
    NSArray *colors;
    UISegmentedControl *seg;
    BOOL shouldEraser;
    UISlider *slider;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    colors=@[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor whiteColor]];
    points=[[NSMutableArray alloc]init];
    [self initUI];
}

-(void)initUI
{
    view=[[SWView alloc]initWithFrame:self.view.frame];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(addPoints:)];
    [view addGestureRecognizer:pan];

    
    seg=[[UISegmentedControl alloc]initWithItems:@[@"红色",@"绿色",@"蓝色"]];
    seg.frame=CGRectMake(0, 21, self.view.frame.size.width, 30);
    seg.selectedSegmentIndex=0;
    [seg addTarget:self action:@selector(segClick) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    UIButton *clearButton=[[UIButton alloc]initWithFrame:CGRectMake(10, 60, 80, 30)];
    clearButton.backgroundColor=[UIColor grayColor];
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
    UIButton *saveButton=[[UIButton alloc]initWithFrame:CGRectMake(100, 60, 80, 30)];
    saveButton.backgroundColor=[UIColor grayColor];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    
    UIButton *renewButton=[[UIButton alloc]initWithFrame:CGRectMake(190, 60, 80, 30)];
    renewButton.backgroundColor=[UIColor grayColor];
    [renewButton setTitle:@"还原" forState:UIControlStateNormal];
    [renewButton addTarget:self action:@selector(renew) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renewButton];
    
    UIButton *eraserButton=[[UIButton alloc]initWithFrame:CGRectMake(280, 60, 80, 30)];
    eraserButton.backgroundColor=[UIColor grayColor];
    [eraserButton setTitle:@"橡皮擦" forState:UIControlStateNormal];
    [eraserButton addTarget:self action:@selector(eraser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:eraserButton];
    
    slider=[[UISlider alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 20)];
    slider.minimumValue=3.0;
    slider.maximumValue=20.0;
    [self.view addSubview:slider];
    
    
}


-(void)addPoints:(UIPanGestureRecognizer *)pa
{
    
    if (pa.state==UIGestureRecognizerStateBegan)
    {
        if (shouldEraser) {
            line=[[SWLine alloc]initWithLineColor:[colors lastObject]];
        }else{
        line=[[SWLine alloc]initWithLineColor:colors[seg.selectedSegmentIndex]];
        }
        line.lineWidth=slider.value;
        [view.lines addObject:line];
    }if (pa.state==UIGestureRecognizerStateChanged) {
        CGPoint point =[pa locationInView:[pa.view superview]];
       
        [line.points addObject:[NSValue valueWithCGPoint:point]];
    }
    [view setNeedsDisplay];
}
-(void)segClick
{
    shouldEraser=NO;
}
-(void)clear
{
    [view.lines removeAllObjects];
    [view setNeedsDisplay];
}
//还原
-(void)renew
{
    [view.lines removeLastObject];
    [view setNeedsDisplay];
}
//橡皮擦
-(void)eraser:(UIButton *)button
{
    shouldEraser=!shouldEraser;
    NSString *title=shouldEraser?@"取消":@"橡皮擦";
    [button setTitle:title forState:UIControlStateNormal];
}
#pragma mark== 保存截屏图片到相册
-(void)save
{
    UIImage *image=[self screenShots];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相册中
}
#pragma mark==截屏
-(UIImage *)screenShots
{
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context=UIGraphicsGetCurrentContext();//创建一个画布
    [view.layer renderInContext:context];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
