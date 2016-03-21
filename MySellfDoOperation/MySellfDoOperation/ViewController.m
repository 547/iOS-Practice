//
//  ViewController.m
//  MySellfDoOperation
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "MyOperation.h"
@interface ViewController ()<MyOperationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //http://img3.imgtn.bdimg.com/it/u=3841157212,2135341815&fm=21&gp=0.jpg
    
    //自定义operation
    
    MyOperation *op= [[MyOperation alloc]downLoadImageWithurl:@"http://c.hiphotos.baidu.com/image/h%3D300/sign=8ad8896b4a086e0675a8394b32097b5a/023b5bb5c9ea15ce0492f553b0003af33a87b26f.jpg" delegate:self];
    
    NSOperationQueue *queue=[[NSOperationQueue alloc]init];
    
    [queue addOperation:op];
    
    
}

-(void)getImage:(UIImage *)image
{
    self.myImage.image=image;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
