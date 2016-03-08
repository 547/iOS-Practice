//
//  ViewController.m
//  模仿Android写父类ViewControll
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToTest:(UIButton *)sender {
    [self presentViewController:[[TestViewController alloc]init] animated:YES completion:nil];
}
@end
