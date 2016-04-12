//
//  ViewController.h
//  SelfDoBlock
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^blockTest2)(void);
@interface ViewController : UIViewController
{
    blockTest2 blockTest21;
}
//带Block的方法
-(void)blockTestMethod1:(void(^)(void))blockTest1;
- (IBAction)myButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFrist;
- (IBAction)myBlockTestButton:(UIButton *)sender;

@end

