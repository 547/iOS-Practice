//
//  ViewController.m
//  CategoryTest
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "NSString+MD5.h"
@interface ViewController ()<UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString *str=@"  1  2  3  ";
    
    [str MD5];
    
    [NSString Base64];
    
    NSLog(@"%@",[str trim]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
