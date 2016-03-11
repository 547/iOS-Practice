//
//  NumberViewController.m
//  SMSTest
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "NumberViewController.h"
#import <SMS_SDK/SMSSDK.h>
@interface NumberViewController ()

@end

@implementation NumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
//无UI获取验证码
- (IBAction)getCode:(UIButton *)sender {
    
#pragma mark - 支持获取验证码和提交验证码 (get the verification code and commit verifacation code)
    /**
     *  @from                    v1.1.1
     *  @brief                   获取验证码(Get verification code)
     *
     *  @param method            获取验证码的方法(The method of getting verificationCode)
     *  @param phoneNumber       电话号码(The phone number)
     *  @param zone              区域号，不要加"+"号(Area code)中国是86
     *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
     *  @param result            请求结果回调(Results of the request)
     */
    
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.numberField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        }else{
        NSLog(@"获取验证码失败，错误信息：%@",error);
        }
    }];
}
//提交验证码
- (IBAction)sentCode:(UIButton *)sender {
    /**
     * @from               v1.1.1
     * @brief              提交验证码(Commit the verification code)
     *
     * @param code         验证码(Verification code)
     * @param phoneNumber  电话号码(The phone number)
     * @param zone         区域号，不要加"+"号(Area code)
     * @param result       请求结果回调(Results of the request)
     */

    [SMSSDK commitVerificationCode:self.codeFiled.text phoneNumber:self.numberField.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
        }else{
            NSLog(@"验证失败，错误信息：%@",error);
        }

    }];
    
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
