//
//  MyAnnotation.h
//  MapTest2
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 Seven. All rights reserved.
//
//自定义大头针类 好处是将来可以和系统的进行区分
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
//！！！！！！自定义地图标记，必须实现MKAnnotation协议，并且重写的属性必须和MKAnnotation里面的属性名字一模一样，不然就会崩溃或者没东西显示！！！！！！===这就相当于重写父类
@interface MyAnnotation : NSObject<MKAnnotation>
@property(nonatomic)CLLocationCoordinate2D coordinate;//坐标
@property(nonatomic,copy)NSString *title;//标题
@property(nonatomic,copy)NSString *subtitle;//子标题
//只能把名字设为subtitle，不然不显示
//Annotation==注释
@end
