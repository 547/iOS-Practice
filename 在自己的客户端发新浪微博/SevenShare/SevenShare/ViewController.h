//
//  ViewController.h
//  SevenShare
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostRequest.h"
@interface ViewController : UIViewController<PostRequestDelegate>

@property (weak, nonatomic) IBOutlet UILabel *la;

@end

