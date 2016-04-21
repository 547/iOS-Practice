//
//  NextViewController.m
//  RAC
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NextViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIButton *_button =[[UIButton alloc]init];
    _button.frame =CGRectMake(150, 250, 100, 30);
    [_button setBackgroundColor:[UIColor redColor]];
    [_button setTitle:@"返回" forState:UIControlStateNormal];
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.view addSubview:_button];
    
    
    
    UIButton *_button22 =[[UIButton alloc]init];
    _button22.frame =CGRectMake(10, 250, 100, 30);
    [_button22 setBackgroundColor:[UIColor redColor]];
    [_button22 setTitle:@"移除夜间" forState:UIControlStateNormal];
    [[_button22 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"移除夜间");
        UIWindow *win =[[UIApplication sharedApplication].windows lastObject];
        win.alpha =0;
        win.hidden =YES;
    }];
    [self.view addSubview:_button22];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
