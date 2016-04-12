//
//  NextViewController.h
//  SelfDoBlock
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NextViewController : UIViewController
- (IBAction)myButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *nextText;
//block可以像变量一样用@property描述
@property(nonatomic,copy)void(^myPropertyBlock) (NSString *str);
@end
