//
//  ViewController.h
//  ASITest
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)getButton:(UIButton *)sender;
- (IBAction)postButton:(UIButton *)sender;
- (IBAction)updataButton:(UIButton *)sender;
- (IBAction)chaKanWangLuoButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

- (IBAction)duanDianDownLoadButton:(UIButton *)sender;
- (IBAction)cancelButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIProgressView *downLoadProgress;


@end

