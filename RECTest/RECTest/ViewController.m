//
//  ViewController.m
//  RECTest
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import <ShareREC/ShareREC.h>
@interface ViewController ()

@end

@implementation ViewController
/**
 
 ShareREC不支持模拟器屏幕录像!

 **/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
//开始录屏
- (IBAction)startREC:(UIButton *)sender {
    //粘贴到你要开始录制视频的位置，如：游戏关卡开始，或点击某个按钮。
    /**
     *	@brief	开始录制视频
     */
    [ShareREC startRecording];
    
    
    
}
//结束录屏
- (IBAction)endREC:(UIButton *)sender {
    /**
     *	@brief	结束录制视频
     *
     *  @param  finishedHandler 完成事件处理
     */
    [ShareREC stopRecording:^(NSError *error) {
        //结束录制回调，写入你需要进行的后续操作====block参数为录制完成后回调，可以写入需要执行的操作。如：分享视频。
    }];
    
    
    
    
}
//编辑视频
- (IBAction)editREC:(UIButton *)sender {
    /**这个方法已经被下面的editLastRecording替代
     *  编辑最后录制的视频
     *
     *  @param title        标题
     *  @param userData     用户数据
     *  @param closeHandler 关闭事件
     */

    [ShareREC editLastRecordingWithTitle:@"录屏测试" userData:@{@"score":@(2000)} onClose:nil];
    
    /**
     *  编辑最后录制的视频
     *
     *  @param block 返回回调
     *
     *  @return YES 表示成功进入编辑界面，NO 表示不能编辑
     */
    [ShareREC editLastRecording:^(BOOL cancelled) {
        if (cancelled) {
            //YES 表示成功进入编辑界面，NO 表示不能编辑
            NSLog(@"不能编辑");
        }else{
        NSLog(@"成功进入编辑界面");
        }
    }];
    
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
