//
//  ViewController.h
//  BaiDuMapHomeWork
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
typedef enum {
    WalkingMode = 0,             /// 步行模式
    TransitMode =1,               /// 公交模式
    DrivingMode =2,    /// 驾车模式
    RidingMode =3,    /// 骑行模式
} RouteSearchMode;
@property(nonatomic)RouteSearchMode routeSeachMode;
@end

