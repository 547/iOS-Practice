//
//  ViewController.m
//  BlockTest
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
/**
 Block块的使用
 
 block==块==指向代码块的指针===也就是说代码块也需要指针的
 可以类比方法
 
 
 
 **/
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     一.无返回类型无参数的block
     void(^block) (void)=nil;==相当于声明方法===返回类型（^脱字节：block块代码的标记==相当于方法的名字）（参数类型）
     */
    void(^block) (void)=nil;//1.声明
    
    //2.block的实现
    block=^(void){
    //写实现的代码==相当于方法体
        NSLog(@"这是一个无返回类型无参数的block");
    
    };
    //3.调用（如果有参数就传参数）
    block();
    
    
    
    
    void(^newBlock) (void);
    newBlock=^(void){
        NSLog(@"newBlock");
    };
    newBlock();
    
    
    
    //二、无返回类型有参数的block
    void(^stringBlock) (NSString *string)=nil;//1.声明
    //由于这个Block是带参数的,block实现的时候^(需不需要追加参数取决于声明的block)
    stringBlock=^(NSString *string){//2.实现
        NSLog(@"有参数的block，参数为==%@",string);
    };
    stringBlock(@"123");//3.调用
    
    
    
    //三、有返回类型，带多个参数的block
    int(^intBlock) (NSString *strA,NSString *strB)=nil;//1.声明
    //返回a+b的值；
    intBlock=^(NSString *strA,NSString *strB){//2.实现
        int b=[strA intValue]+[strB intValue];
        return b;
    };
    
   int a= intBlock(@"12233",@"455");//3.调用
    NSLog(@"a===%d",a);
    
    
    
    
    //四、block的声明和实现是可以写在一起的
    
    void(^allBlock) (NSString *strAA)=^(NSString *strAA){
    
        NSLog(@"====%@",strAA);
    
    };
    allBlock(@"787547");
    
    
    
    
    /*
     block总结：
     1.block是一个具有一定类型的指针；
     2.指向一块代码；
     3.调用该指针执行此块代码；
     
     
     */
    
    
    //五、
   thisBlock =^(void){
        
        
        NSLog(@"全局block");
    };
    
    //六、调用系统方法时方法包含的Block参数系统内部都是有对应的指针去调用该参数
//    [self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>];
    
    
    [self blockMod:@"123" completion:^(NSString *strB) {
        NSLog(@"12222");
    }];
    
    
    
    //如果遇到一个相同特性的Block时可以向使用类别一样使用block

    myBlock blockC=^(NSString *strC){//实现
    
        NSLog(@"ty block");
    };
    blockC(@"1111");//调用
    
    
    blockD=^(NSString *st){
        
        NSLog(@"sr====%@",st);
    };

    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(50, 50, 50, 50)];
    view.backgroundColor=[UIColor redColor];
    [self.view addSubview:view];
    [UIView animateWithDuration:2 animations:^{
        view.frame=CGRectMake(20, 20, 20, 20);
        view.alpha=0.5;
        view.backgroundColor=[UIColor blueColor];
    } completion:^(BOOL finished) {
        nil;
    }];
    
}

-(void)blockMod:(NSString *)strA completion:(void(^) (NSString *strB))completion
{

    NSLog(@"45554456656");
    completion(@"12222");

}
- (IBAction)quanJuButon:(UIButton *)sender {
    
    [self blockMod:@"1111" completion:^(NSString *strB) {
        NSLog(@"7777");
    }];

    blockD(@"ty 全局");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
