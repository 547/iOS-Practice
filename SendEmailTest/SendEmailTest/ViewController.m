//
//  ViewController.m
//  SendEmailTest
//
//  Created by mac on 16/3/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>//1.导入MessageUI框架
@interface ViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 IOS发送电子邮件:
 我们可以使用IOS设备中的电子邮件应用程序发送电子邮件。
 实例步骤
 1、选择项目文件，然后选择目标，然后添加MessageUI.framework
 2.创建一个MFMailComposeViewController对象
 3.设置代理
 */

//发邮件
- (IBAction)sendEmail:(id)sender {
    //2.创建一个MFMailComposeViewController对象
    MFMailComposeViewController *mailVC=[[MFMailComposeViewController alloc]init];
    //Compose==写作
    mailVC.mailComposeDelegate=self;//3.设置代理
    
    //下面两项可以不设
//    [mailVC setSubject:@"email标题"];//4.设置邮件标题,和MailComposeViewController的导航标题
//    [mailVC setMessageBody:@"测试邮件" isHTML:NO];//5.设置邮件正文
    [self presentViewController:mailVC animated:YES completion:nil];
    
    
}
#pragma mark==MFMailComposeViewControllerDelegate
//发送邮件后调用的方法
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result) {
        NSLog(@"结果：%d",result);
    }
    if (error) {
        NSLog(@"error==%@",error);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
