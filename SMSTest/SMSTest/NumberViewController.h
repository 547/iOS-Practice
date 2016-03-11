//
//  NumberViewController.h
//  SMSTest
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *numberField;
- (IBAction)getCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *codeFiled;
- (IBAction)sentCode:(UIButton *)sender;

@end
