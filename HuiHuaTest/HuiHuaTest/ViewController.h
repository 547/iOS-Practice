//
//  ViewController.h
//  HuiHuaTest
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)juXing:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *huaBan;

- (IBAction)yuanXing:(UIButton *)sender;

- (IBAction)huaQuXian:(UIButton *)sender;
- (IBAction)shuangHuDuQuXian:(UIButton *)sender;


@end

