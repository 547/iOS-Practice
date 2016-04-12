//
//  ViewController.h
//  BlockTest
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
//为Block起个别名
typedef void (^myBlock)(NSString *strC);
@interface ViewController : UIViewController
{
void(^thisBlock) (void);

    myBlock blockD;

}

- (IBAction)quanJuButon:(UIButton *)sender;
//两个参数的block方法
-(void)blockMod:(NSString *)strA completion:(void(^) (NSString *strB))completion;
- (IBAction)quanjuBlock:(UIButton *)sender;

@end

