//
//  ViewController.m
//  Seven
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//分享按钮
- (IBAction)shareButton:(UIButton *)sender {
    //1、创建分享参数（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    NSArray *imageArray=@[[UIImage imageNamed:@"1.png"],[UIImage imageNamed:@"2.png"],[UIImage imageNamed:@"3.png"],[UIImage imageNamed:@"4.png"]];
    if (imageArray) {
        NSMutableDictionary *shareParams=[NSMutableDictionary dictionary];
        /**
         *  设置新浪微博分享参数
         *
         *  @param text      文本
         *  @param title     标题
         *  @param image     图片对象，可以为UIImage、NSString（图片路径）、NSURL（图片路径）、SSDKImage
         *  @param url       分享链接
         *  @param latitude  纬度
         *  @param longitude 经度
         *  @param objectID  对象ID，标识系统内内容唯一性，应传入系统中分享内容的唯一标识，没有时可以传入nil
         *  @param type      分享类型，仅支持Text、Image、WebPage（客户端分享时）类型
         */
        [shareParams SSDKSetupSinaWeiboShareParamsByText:self.text.text title:@"微博分享测试" image:imageArray[0] url:[NSURL URLWithString:@"http://mob.com"] latitude:5.2 longitude:3.2 objectID:nil type:SSDKContentTypeAuto];
        
        
        
        
        /**第一种分享方式
         会跳出ShareSDK自带ActionSheet，然后再显示ShareSDK自带的内容编辑视图
         *  显示分享菜单
         *
         *  @param view                     要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图
         *  @param items                    菜单项，如果传入nil，则显示已集成的平台列表
         *  @param shareParams              分享内容参数
         *  @param shareStateChangedHandler 分享状态变更事件
         *
         *  @return 分享菜单控制器
         */
//        UIImageView *ima=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.png"]];
//        ima.frame=CGRectMake(0, 0, 50, 50);
        
        
//        //2、分享（可以弹出我们的分享菜单和编辑界面）
//        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                           {
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           default:
//                               break;
//                       }
//                   }
//         ];}
        
        
        
        
        
        
        /**第二种分享方式
         直接跳出ShareSDK自带的分享内容编辑界面
         *  显示内容编辑视图
         *
         *  @param platformType             分享的平台类型
         *  @param otherPlatformTypes       除分享平台外，还可以分享的平台类型。
         *  @param shareParams              分享内容参数
         *  @param shareStateChangedHandler 分享状态变更事件
         *
         *  @return 内容编辑视图控制器
         */

//        [ShareSDK showShareEditor:SSDKPlatformTypeSinaWeibo otherPlatformTypes:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//            switch (state) {
//                case SSDKResponseStateSuccess:
//                    NSLog(@"分享成功");
//                    break;
//                case SSDKResponseStateFail:
//                    NSLog(@"分享失败");
//                    break;
//                default:
//                    break;
//            }
//        }];

        
        
        
        
        /**第三种分享方式
         *  分享内容=====无ShareSDK自带UI编辑界面的分享，这种方式可以用于自定义分享界面的分享
         *
         *  @param platformType             平台类型
         *  @param parameters               分享参数
         *  @param stateChangeHandler       状态变更回调处理
         */

        [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess:
                        NSLog(@"分享成功");
                        break;
                case SSDKResponseStateFail:
                        NSLog(@"分享失败");
                        break;
                    
                default:
                    break;
            }
        }];
        
        
        
    }
}
    
   


























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
