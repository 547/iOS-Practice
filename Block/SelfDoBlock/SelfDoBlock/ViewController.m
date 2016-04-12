//
//  ViewController.m
//  SelfDoBlock===========block的学习
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    //block不可以改变block块外部参数，如果非要改变就要
    
    __block int x=0;
    void(^myBlock) (void)=^(void){
    
        x+=2;
        NSLog(@"x=%d",x);
    };
    myBlock();
    
    
    //block可以像变量一样用@property描述==见NextViewController.h文件
    
    
    
    
    
    
}

    //block可以在方法外面声明、实现==但是不知道怎么调用
    void (^block)(void)=^(void){
        
        NSLog(@"方法外面的block");
        
    };

-(void)blockTestMethod1:(void(^)(void))blockTest1
{
    //block块在一个方法中作为一个参数存在，要让这个Block起作用，就要遵循这样的原则：1.谁声明谁调用==在方法中声明，就要在方法体内调用这个Block；2.谁调用方法,谁实现Block
   
    
    blockTest1();//调用block
}
- (IBAction)myBlockTestButton:(UIButton *)sender {
    
    [self blockTestMethod1:^{//实现Block
        NSLog(@"就是在这里实现Block的");
    }];
    
}
- (IBAction)myButton:(UIButton *)sender {
    
    NextViewController *next=[[NextViewController alloc]init];
    
    
    next.myPropertyBlock=^(NSString *s){//实现NextViewController的Block块
        self.textFrist.text=s;//将NextViewController那边通过调用Block传过来的值赋给self.textFrist.text
    };
    
    
    [self presentViewController:next animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
