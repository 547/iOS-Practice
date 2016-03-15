//
//  ViewController.m
//  MapTest
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@end
@implementation ViewController
{
    CLLocationManager *locationManager;//定位管理器
    CLGeocoder *geocode;//地理编码反编码的的工具类对象
    CLGeocoder *ge;
}

/*
 地图：1.定位
      2.导航
      3.定位周边
 苹果常用地图：内部集成高德（系统自带）
 开发角度：百度、高德、谷歌
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self locationTest];
}
/*
 定位==使用地图一定要用的功能，同时用可以和地图脱离开单独使用。
 定位iOS8之后用户授权方式改变了，需要在plist文件配置属性
 //    iOS 8 必须在 Info.plist 文件中配置 NSLocationAlwaysUsageDescription 或者 NSLocationWhenInUseUsageDescription 属性来告诉用户使用定位服务的目的。值为告知用户的提示信息。
 //    使用定位前还需要使用 requestAlwaysAuthorization，requestWhenInUseAuthorization 方法获得用户的允许。
 一定要导入定位头文件#import <CoreLocation/CoreLocation.h>
 地图的是#import <MapKit/MapKit.h>
 */
-(void)locationTest
{

    locationManager =[[CLLocationManager alloc]init];
    //配置此次定位的一些必要的信息（定位的范围，更新的频率。。。）
    //更新的范围
    locationManager.desiredAccuracy=kCLLocationAccuracyBestForNavigation;
    //更新的频率
    locationManager.distanceFilter=10;
    //开启定位（iOS定位获取位置分为三种方式：1.基站，2.GPS，3.WIFI）
    //代码开启授权
    [locationManager requestAlwaysAuthorization];
    [locationManager requestWhenInUseAuthorization];
    //开始更新位置
    [locationManager startUpdatingLocation];
    //更新设备朝向【模拟器不可以】
    [locationManager startUpdatingHeading];
    //定位是否成功，以及成功之后的地理信息，都要在协议中获取
    locationManager.delegate=self;
    
    
    /*
     火星坐标转换：（地理编码，反地理编码）
     地理编码：知道地名获取经纬度
     反地理编码：知道经纬度获取地名
     */
    //系统提供的可以地理编码，反地理编码的类。PS：一个当前对象只能执行一次操作
    geocode=[[CLGeocoder alloc]init];
    //地理编码
    [geocode geocodeAddressString:@"郑州市远大理想城" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *lastMark=[placemarks lastObject];
       CLLocationDegrees lo=  lastMark.location.coordinate.longitude;
       CLLocationDegrees la= lastMark.location.coordinate.latitude;
        NSLog(@"径度：%f，纬度：%f",lo,la);
    }];
    
    //反地理编码
    ge=[[CLGeocoder alloc]init];
    //116.342839,39.947309==北京动物园的坐标
    CLLocation *loca=[[CLLocation alloc]initWithLatitude:39.947309 longitude:116.342839];
    [ge reverseGeocodeLocation:loca completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *ma=[placemarks lastObject];
        NSString *cuntry=ma.country;//国家
        NSString *shi=ma.locality;//市区
        NSString *address=ma.name;//详细地址
        NSLog(@"位置：%@%@%@",cuntry,shi,address);
    }];
    


}
#pragma mask===CLLocationManagerDelegate
//更新位置==从旧位置到新位置
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%f,%f",oldLocation.altitude,oldLocation.verticalAccuracy);
   
}
//更新位置数组
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//当前这个方法是一直调用的
    // CLLocation==包含经纬度、海拔高度，一般情况下都是获取最后一个
    CLLocation *location=[locations lastObject];
    //纬度
   CLLocationDegrees la= location.coordinate.latitude;
    //径度
   CLLocationDegrees lo= location.coordinate.longitude;
    //海拔高度
    double height= location.altitude;
    NSLog(@"当前海拔高度：%f，径度：%f，纬度：%f",height,lo,la);
    CLGeocoder *geo=[[CLGeocoder alloc]init];
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       CLPlacemark *pl= [placemarks lastObject];
       NSString *str= pl.name;
        NSLog(@"====%@",str);
    }];
    

}
//更新设备朝向{模拟器不可以}
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading
{
    //朝向：地理朝向，地磁朝向
    
    //地磁：用户无法控制，自动根据磁场捕获位置，如遇到磁场特别强烈的情况会不稳定
    //地理朝向：可以控制
    //地磁朝向：magneticHeading
   CLLocationDirection mag= newHeading.magneticHeading;
    
    //地理朝向：
   CLLocationDirection ture= newHeading.trueHeading;
    
    //精准度
   CLLocationDirection acc= newHeading.headingAccuracy;
    NSLog(@"地磁朝向：%f，地理朝向：%f，精准度:%f",mag,ture,acc);
}
//改变授权状态
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusDenied:
            NSLog(@"拒绝授权");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"一直授权，前台后台都可以用");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"正在使用授权，前台运行的时候");
            break;
        default:
            break;
    }
}
//定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code]==NSNotFound) {
        NSLog(@"没有找到");
    }
    if ([error code]==kCLErrorDenied) {
        NSLog(@"没有授权");
    }
    if ([error code]==kCLErrorLocationUnknown) {
        NSLog(@"无法获得定位信息");
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
