//
//  AppDelegate.m
//  UncaughtExceptionHandler
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self getBugReson];
    
    return YES;
}
//异常捕获
-(void)getBugReson
{
    //需要调用C的函数
    NSSetUncaughtExceptionHandler(&getException);
}
//C的函数
void getException(NSException *exception)
{
//1.一旦进入到该方法 那么程序是肯定要挂掉的 要及时的整理崩溃日志，崩溃版本，崩溃设备，以及崩溃时间  及时的发送给服务器
   NSString *deviceName= [UIDevice currentDevice].name;//获取设备的名称例如："My iPhone"
   NSString *model = [UIDevice currentDevice].model;//获取设备 例如：@"iPhone", @"iPod touch"
   NSString *systemVersion = [UIDevice currentDevice].systemVersion;//获取设备的系统版本如：@"4.0"
   NSString *systemName = [UIDevice currentDevice].systemName;//获取设备系统名称如：ios
   NSDate *now = [NSDate date];//获取发生崩溃时间
    
//2.获取程序崩溃的原因等相关信息
    /*
     @property (readonly, copy) NSString *name;==异常类型
     @property (nullable, readonly, copy) NSString *reason;==非常重要，崩溃的原因
     @property (nullable, readonly, copy) NSDictionary *userInfo;==用户信息
     
     @property (readonly, copy) NSArray<NSNumber *> *callStackReturnAddresses;
     @property (readonly, copy) NSArray<NSString *> *callStackSymbols;==得到当前调用栈信息
     */
    NSString *exName=exception.name;
    NSString *exReason=exception.reason;
    NSArray *addresses=exception.callStackReturnAddresses;
    NSArray *symbols=exception.callStackSymbols;
//3.将程序崩溃前获取得到的异常信息发送到公司的服务器为异常提供的专用接口
//3.或者发送到开发者的邮箱，不过此种方式需要得到用户的许可，因为iOS不能后台发送短信或者邮件，会弹出发送邮件的界面，只有用户点击了发送才可发送。 不过，此种方式最符合苹果的以用户至上的原则。
    
    //异常的所有信息==即要返回到服务器或邮箱的异常信息
    NSString *exInfo=[NSString stringWithFormat:@"设备名称：%@\n设备：%@\n设备的系统版本:%@\n设备系统名称:%@\n发生崩溃时间:%@\n异常类型:%@\n崩溃的原因:%@\n当前调用栈信息:%@\n当前调用栈地址：%@\n",deviceName,model,systemVersion,systemName,now,exName,exReason,symbols,addresses];
    NSLog(@"%@",exInfo);
    
    //把异常信息发至开发者邮箱
    NSString *urlStr=[NSString stringWithFormat:@"mailto://1093031562@qq.com?subject=bug报告，感谢您的配合！&body=%@",exInfo];
    NSURL *url=[NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication]openURL:url];

    
}












- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
