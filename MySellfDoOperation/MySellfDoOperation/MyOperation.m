//
//  MyOperation.m
//  MySellfDoOperation
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation
/*
 自定义operation的步骤：
 1.创建一个继承于nsoperation的类
 2.实现Main方法
 3.将要处理的事件放到Main方法里面
 */
-(id)downLoadImageWithurl:(NSString *)aUrlString delegate:(id<MyOperationDelegate>)aDelegate
{

    if (self ==[super init]) {
        //
        self.urlString=aUrlString;
        self.delegate=aDelegate;
        NSLog(@"下载=====%d",[NSThread isMainThread]);
    }
    return self;
}
-(void)main//自定义operation一定要实现的方法===在分线程执行===意味着想要处理的时间都在Main方法里面实现就可以
{
    NSLog(@"%d",[NSThread isMainThread]);
    //在下载之前，要先处理由于operation自身导致的Main方法结束==如：operation被取消了
    if (self.isCancelled) {
        return;
    }
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
    UIImage *image=[UIImage imageWithData:data];
    if (image) {
    //这是分线程不可以刷新UI
       //由于当前self并不具备刷新UI的能力，所以最好的方法就是生命delegate，通过参数赋值的形式把VIewcontroller的self传递进去
        //[self.delegate respondsToSelector:@selector(getImage:)]==检测是否实现getImage代理方法
        if ([self.delegate respondsToSelector:@selector(getImage:)]) {
            //self.delegate ==使用者对象==ViewController
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(getImage:) withObject:image waitUntilDone:YES];
        }
        
    }
}
@end
