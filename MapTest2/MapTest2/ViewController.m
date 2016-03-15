//
//  ViewController.m
//  MapTest2
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
@interface ViewController ()<MKMapViewDelegate>

@end

@implementation ViewController
{
    MKMapView *map;//地图视图继承自UIVIew
    CLLocationManager *locM;//定位管理器
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self showMap];
}

-(void)showMap
{
    locM=[[CLLocationManager alloc]init];
    [locM requestAlwaysAuthorization];
    
    
    
    //系统地图:常规的地图展示，附近热点都可以借助系统地图完成
    //第三方地图:很方便提供一些比较好的功能 方便即时操作。
    map=[[MKMapView alloc]initWithFrame:self.view.frame];
    /*
     MKMapTypeStandard = 0,==标准
     MKMapTypeSatellite,
     MKMapTypeHybrid,===鸟瞰
     MKMapTypeSatelliteFlyover ,===卫星
     MKMapTypeHybridFlyover===鸟瞰==Flyover==立交
     */
    map.mapType=0;
    /*
     MKUserTrackingModeNone = 0, // the user's location is not followed==默认不追踪
     MKUserTrackingModeFollow, // the map follows the user's location==根据用户当前的位置追踪
     MKUserTrackingModeFollowWithHeading, // the map follows the user's location and heading==根据用户当前的位置和设备的朝向追踪==这个会在Annotation那里出现一束与设备朝向方向一致的光束
     */
    //设置用户的追踪模式
    map.userTrackingMode=MKUserTrackingModeFollowWithHeading;
    //想要某些地图特效的话需要开启对应的代理
    map.delegate=self;
    map.showsUserLocation=YES;//展示用户当前的位置，这里必须配合代理方法didUpdateUserLocation和CLLocationManager一起使用，因为要用到定位。并且CLLocationManager要实现requestAlwaysAuthorization或requestWhenInUseAuthorization
    [self.view addSubview:map];
    
}
#pragma mask==MKMapViewDelegate
//更新用户当前的位置
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //让地图移动到指定的位置 地图比例不变
    //    [_mapView setCenterCoordinate:location.coordinate];//设置中心坐标
    
    
    //MKCoordinateSpan值为0-1
    MKCoordinateSpan span=MKCoordinateSpanMake(0.5, 0.5);//这里是设置缩放的比例的，地图就会放大到定位的地方
    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.coordinate, span);
    //通过提供的缩放比例来移动到指定的经纬度上面同时显示对应的比例
    [map setRegion:region animated:YES];//设置范围
}

//地图标记注释的View===构建大头针的重用方法>>>UITableViewCell==可以直接理解为UITableView的cellforrow
-(nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    /*
     如果要一次展示很多个Annotation的时候，可以考虑使用重用annotation的方法优化
     实现Annotation的重用类似tableViewcell的重用机制
     */
    
    //1.先判断是否是自己定义的注释Annotation
    //如果在该方法里面不去做判断那么默认情况下所有的大头针都会使用自定义的这种类型，包括系统默认定位的蓝色大头针
    
    //如果要区分就得参照区分单元格的方式来进行（可以判断当前大头针的类型  如果输入自定义的MyAnnotation类 那么就是自定义  否则就是系统的）
/*    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        //2.如果是就使用重用标识符到重用队列中查找是否有可以重用的Annotation
      MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:@"an"];
        if (!view) {
            //3.如果没有找到可以重用的annotation，就重新创建一个
            view=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"an"];
        }
        view.image=[UIImage imageNamed:@"0.png"];//设置annotation的图片，
        view.canShowCallout=YES;//Callout==插图，调出
        view.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];//设置annotation的左边附加视图，只有点击了annotation的时候才会出现和title一样，所以在设置这个属性之前一定要先设置canShowCallout
        view.leftCalloutAccessoryView.frame=CGRectMake(0, 0, 40, 40);
        
        view.annotation=annotation;
        return view;
        
    }else{
    //系统的annotation==就直接返回nil
     return nil;
    }
 */
    
    
    
    /*
     这是另外一种方法，可以实现改变Annotation的颜色和设置展示动画
     */
    if ([annotation isKindOfClass:[MyAnnotation class]]) {
        //2.如果是就使用重用标识符到重用队列中查找是否有可以重用的Annotation
        MKPinAnnotationView *view = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"an"];//MKPinAnnotationView是MKAnnotationView的子类，比MKAnnotationView多两个属性，可以设置Annotation的颜色和设置展示动画
        if (!view) {
            //3.如果没有找到可以重用的annotation，就重新创建一个
            view=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"an"];
        }
        
        view.canShowCallout=YES;//Callout==插图，调出
        view.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];//设置annotation的左边附加视图，只有点击了annotation的时候才会出现和title一样，所以在设置这个属性之前一定要先设置canShowCallout
        view.leftCalloutAccessoryView.frame=CGRectMake(0, 0, 40, 40);
        view.pinTintColor=[UIColor blueColor];//annotation上面那个小圆点的颜色
        view.animatesDrop=YES;//落下的动画
        view.annotation=annotation;
        return view;
        
    }else{
        //系统的annotation==就直接返回nil
        return nil;
    }
    
    
    
}
//选中AnnotationView时会调用的代理方法
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"点击了Annotation");
}






-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //展示自定义地图标记
    MyAnnotation *annotation=[[MyAnnotation alloc]init];
    annotation.coordinate=CLLocationCoordinate2DMake(27.014648, 115.02545);
    annotation.title=@"标题";
    annotation.subtitle=@"子标题";
    [map addAnnotation:annotation];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
