//
//  ViewController.m
//  BaiDuMapTest
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "BaiDuHeader.h"
@interface ViewController ()<BMKLocationServiceDelegate,BMKPoiSearchDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>

@end

@implementation ViewController
{
    
    UITextField *textF;
    int currPage;
    NSMutableArray *annotationArray;
    BMKMapManager *baiDuMap;
    BMKMapView *map;
    BMKLocationService *locationSer;
    BMKPoiSearch *mySearch;
    CLLocationCoordinate2D currLocation;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    currPage=0;
     annotationArray=[[NSMutableArray alloc]init];
    [self showBaiDuMap];//展示地图
    [self openLoaction];//开启定位
}
//展示地图
-(void)showBaiDuMap
{
    baiDuMap=[[BMKMapManager alloc]init];
    BOOL ret=[baiDuMap start:@"uOhQQ45ephGBwDpxBEi91Cn2" generalDelegate:nil];
    if (!ret) {
         NSLog(@"manager start failed!");
    }
    map=[[BMKMapView alloc]initWithFrame:self.view.bounds];
    map.showsUserLocation=YES;//显示定位图层==展示用户的位置===注：自iOS8起，系统定位功能进行了升级，SDK为了实现最新的适配，自v2.5.0起也做了相应的修改，开发者在使用定位功能之前，需要在info.plist里添加（以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription）：NSLocationWhenInUseUsageDescription ，允许在前台使用时获取GPS的描述NSLocationAlwaysUsageDescription ，允许永久使用GPS的描述
    map.userTrackingMode=BMKUserTrackingModeFollowWithHeading;
    map.delegate=self;
    map.zoomEnabled=YES;
    [self.view addSubview:map];
    [self addButton];
}
//开启定位
-(void)openLoaction
{
    //初始化定位BMKLocationService
    locationSer=[[BMKLocationService alloc]init];
    locationSer.delegate=self;
    //开启定位服务
    [locationSer startUserLocationService];
}
-(void)addButton
{
    textF=[[UITextField alloc]initWithFrame:CGRectMake(10, 30, 300, 30)];
    textF.backgroundColor=[UIColor blueColor];
    textF.textColor=[UIColor whiteColor];
    [map addSubview:textF];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(320, 30, 80, 30)];
    button.backgroundColor=[UIColor blueColor];
    [button addTarget:self action:@selector(searchEating) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [map addSubview:button];
}
#pragma mark==BMKLocationServiceDelegate
//处理设备朝向变更信息
-(void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{


}
//更新用户坐标
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [map updateLocationData:userLocation];//地图更新用户的位置
    
    //[map setCenterCoordinate:userLocation.location.coordinate animated:YES];//移动到用户的最新位置
    
   // map.zoomLevel=17;//设置缩放水平值3-21，数字越大放得越大
    currLocation=userLocation.location.coordinate;
}
//检索食品店
-(void)searchEating
{
    [self.view endEditing:YES];
    //如果已经有大头针就先把大头针数组和大头针移除
    if (annotationArray.count>0) {
        [map removeAnnotations:annotationArray];
        [annotationArray removeAllObjects];
        
    }
   
    
//初始化检索对象
    mySearch=[[BMKPoiSearch alloc]init];
    mySearch.delegate=self;
    //发起检索
    BMKNearbySearchOption *searchOption=[[BMKNearbySearchOption alloc]init];
    searchOption.pageCapacity=20;//设置分页数量值为10-50；
    searchOption.pageIndex=currPage;
    searchOption.location=currLocation;//设置搜索位置
    searchOption.radius=1000;//设置搜索的范围
    searchOption.keyword=textF.text;//搜索的关键字
    
    
    NSLog(@"%@",[mySearch poiSearchNearBy:searchOption]?@"搜索成功":@"搜索失败");
    
}

#pragma mark===BMKPoiSearchDelegate
//获取搜索结果的详细信息
-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{


}
//获取搜索结果
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    
    
    NSLog(@"%lu",(unsigned long)poiResult.poiInfoList.count);
    [poiResult.poiInfoList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //遍历poiInfoList
        BMKPoiInfo *info=obj;
        NSLog(@"%@",info.name);
        BMKPointAnnotation *pointAnnotation=[[BMKPointAnnotation alloc]init];
        pointAnnotation.coordinate=info.pt;
        pointAnnotation.title=info.name;
        pointAnnotation.subtitle=info.address;
        [annotationArray addObject:pointAnnotation];
    }];
    [map addAnnotations:annotationArray];
}
#pragma mark==BMKMapViewDelegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
      BMKPinAnnotationView *annotationView=(BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"an"];
        if (!annotationView) {
            annotationView=[[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"an"];
            
        }
        annotationView.pinColor=BMKPinAnnotationColorGreen;
        annotationView.animatesDrop=YES;
        return annotationView;
    }else{
        return nil;
    }

}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
    //初始化起点节点
    BMKPlanNode *startAddress=[[BMKPlanNode alloc]init];
    startAddress.pt=currLocation;//设置起点坐标
    
    //初始化终点节点
    BMKPlanNode *endAddress=[[BMKPlanNode alloc]init];
    endAddress.pt=view.annotation.coordinate;//设置终点坐标
    
    
    BMKWalkingRoutePlanOption *planOp=[[BMKWalkingRoutePlanOption alloc]init];
    planOp.from=startAddress;
    planOp.to=endAddress;
    
    //根据起点终点搜索步行路线
    BMKRouteSearch *routeSearch=[[BMKRouteSearch alloc]init];
   BOOL isOk= [routeSearch walkingSearch:planOp];
    routeSearch.delegate=self;
    NSLog(@"%@",isOk?@"搜索成功":@"搜索失败");
}
//地图的覆盖视图==如：路线
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    
   
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *polylineView=[[BMKPolylineView alloc]initWithOverlay:overlay];
        polylineView.lineWidth=5;
        polylineView.isFocus=YES;
        polylineView.strokeColor=[UIColor redColor];
        return polylineView;
    }
        return nil;
}
#pragma mark==BMKRouteSearchDelegate
//获取步行路线结果
-(void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{

    //如果mapView上面已经有路线图就先移除掉
    if (map.overlays.count>0) {
        [map removeOverlays:map.overlays];
    }
    
    BMKWalkingRouteLine *line= [result.routes lastObject];
    NSArray *stepArray=line.steps;

        for (int i=0; i<stepArray.count; i++) {

        BMKWalkingStep *step=stepArray[i];
            
            //构建路线的每个分段的端点数组
        CLLocationCoordinate2D coorArray[2]={0};
        coorArray[0]=step.entrace.location;
        coorArray[1]=step.exit.location;
            //初始化折线对象
        BMKPolyline *polyLine=[BMKPolyline polylineWithCoordinates:coorArray count:2];
            
            //添加分段纹理绘制折线覆盖物
        [map addOverlay:polyLine];
        
        }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
