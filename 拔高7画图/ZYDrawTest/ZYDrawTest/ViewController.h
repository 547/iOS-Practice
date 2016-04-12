//
//  ViewController.h
//  ZYDrawTest
//
//  Created by broncho on 16/3/22.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYLine.h"

@interface ViewController : UIViewController
{
    ZYLine *line;
    
    NSArray *colors;
    
    int selectIndex;
}

@end

