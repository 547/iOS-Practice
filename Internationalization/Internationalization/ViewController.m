//
//  ViewController.m
//  Internationalization
//  国际化
//  Created by mac on 16/3/17.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self Internationalization];
}
/*
 国际化：应对APP在多个国家运行
 1.应用程序名称
 2.应用程序内固定的文字展示
 3.固定的图片
 4.
 */
-(void)Internationalization
{
    self.myLabel.text=NSLocalizedString(@"labelText", nil);
    self.myImage.image=[UIImage imageNamed:NSLocalizedString(@"image", nil)];//图片国际化第一种方法
//    self.myImage.image=[UIImage imageNamed:@"1.png"];//图片国际化第二种方法
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
