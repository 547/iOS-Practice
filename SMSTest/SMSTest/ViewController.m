//
//  ViewController.m
//  SMSTest====获取验证码
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

#import "NumberViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//无UI获取验证码
- (IBAction)getAuthCode:(UIButton *)sender {

    NumberViewController *nu=[[NumberViewController alloc]init];
    [self presentViewController:nu animated:YES completion:nil];
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
