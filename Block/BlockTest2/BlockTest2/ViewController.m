//
//  ViewController.m
//  BlockTest2=======mrc
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "test.h"
#import "SVPullToRefresh.h"
@interface ViewController ()

@end

@implementation ViewController
{

    int sun2;
    test *t2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    
    //一、局部基本数据类型在Block内赋值==是没有意义的，会报错，
   __block int sun=10;//在mrc下对基本数据类型加上__block,这样Block在访问的时候不会对局部基本数据类型进行值得复制
    void(^block1)(void)=^{
        sun=20;
        sun2=20;//二、全局的基本数据类型不受Block的影响
//        int sum1=110;//block内的局部基本数据类型在Block内访问Block会复制该数据类型的值
    };
    NSLog(@"===%d",sun);//===10
    block1();
    NSLog(@"===%d",sun);//===20
    
    
    
    
    //三、局部的非基本数据类型===在Block内部访问的时候会把指针的地址复制一份，所以Block内部的指针内存地址不一样，如果给该非基本数据类型加上__block后，在Block内访问就不会拷贝指针地址，Block内外的指针内存地址就不变
   __block test *t=[[test alloc]init];
    NSLog(@"=1======%@",t);//%@===对象的内存地址
    NSLog(@"=1====%p",&t);//对象的指针的内存地址
    
    t.name=@"111";
    
    void(^block2)(void)=^{
    
        t.name=@"11122222";
        NSLog(@"==2=====%@",t);//%@===对象的内存地址
        NSLog(@"==2===%p",&t);//对象的指针的内存地址

    };
    block2();
    NSLog(@"=====++++%@",t.name);
    
    
    
    //四、全局的非基本数据类型===全局以及静态所修饰的内存地址都是固定的，Block在内部使用的时候都是直接取得的内存地址，所以这两者在Block内部访问的时候内存地址（指针和对象的内存地址）不会发生改变
    t2=[[test alloc]init];
    NSLog(@"==3=1===%@",t2);
     NSLog(@"=3=1==%p",&t2);
    void(^block3)(void)=^{
    NSLog(@"==3=2===%@",t2);
        NSLog(@"=3=2==%p",&t2);
    
    };
    block3();
    
    
    //五、ARC状态下在Block内部访问self的时候,要注意报循环引用警告
    //循环引用：首先双方的相互持有；当tableView调用Block方法的时候对该方法进行了一次拷贝，此时self持有Block，而当Block内部去访问self的时候回对当前的self retain一次从而持有当前的self，所以造成循环引用
    
    //解决方案 mrc下创建对应的self对象用__block修饰self对象，arc下用__weak 修饰self对象（弱引用）
//    __block ViewController *weSelf=self;
//    __weak ViewController *weakSelf=self;
    [_table addPullToRefreshWithActionHandler:^{
//        [weakSelf test1];
    }];
    
    
    
    //ASI
    
    HttpManager *http=[[HttpManager alloc]init];
    [http setRequestWithUrl:@"http://www.baidu.com"];
    http.httpBlock=^(ASIHTTPRequest *request){//实现
    
        NSLog(@"=111====%@",request.responseString);
    
    };
    
    
    
}
-(void)test1{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
//    [_table release];
//    [super dealloc];
}
@end
