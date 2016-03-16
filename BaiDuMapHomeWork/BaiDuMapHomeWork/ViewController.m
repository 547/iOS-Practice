//
//  ViewController.m
//  BaiDuMapHomeWork
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewController.h"
#import "BaiDuHeader.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<BMKLocationServiceDelegate,MyTableViewControllerDelegate,BMKPoiSearchDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>

@end

@implementation ViewController
{
    MyTableViewController *tableLeft;
    MyTableViewController *tableRight;
    BMKMapView *map;
    BMKLocationService *locationService;
    NSArray *leftArray;
    NSArray *rightArray;
    CLLocationCoordinate2D currLocation;
    BMKAnnotationView *selectedAnnotationView;
    BMKRouteSearch *routeSearch;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI
{
    leftArray=@[@"火锅",@"网吧",@"酒店"];
    tableLeft=[[MyTableViewController alloc]init];
    tableLeft.tableArray=leftArray;
    tableLeft.tag=100;
    tableLeft.delegate=self;
    tableLeft.view.frame=CGRectMake(10, 30, SCREENWIDTH*0.5-15, SCREENHEIGHT*0.5-35);
    [self.view addSubview:tableLeft.view];
    
    rightArray=@[@"步行",@"公交",@"驾车",@"骑行"];
    tableRight=[[MyTableViewController alloc]init];
    tableRight.tableArray=rightArray;
    tableRight.tag=101;
    tableRight.delegate=self;
    tableRight.view.frame=CGRectMake(SCREENWIDTH*0.5+5, 30, SCREENWIDTH*0.5-15, SCREENHEIGHT*0.5-35);
    [self.view addSubview:tableRight.view];
    [self showBaiDuMapFristStep];
    [self showBaiDuMap];
}
-(void)showBaiDuMapFristStep
{
// 要使用百度地图，请先启动BaiduMapManager
    BMKMapManager *mapManager=[[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    [mapManager start:@"OWrgXsF6CDVN0za3DNjh3T8G" generalDelegate:nil];
}
-(void)showBaiDuMap
{
    map=[[BMKMapView alloc]initWithFrame:CGRectMake(10, tableLeft.view.frame.size.height+5, SCREENWIDTH-20, SCREENHEIGHT-tableLeft.view.frame.size.height-15)];
    map.delegate=self;
    map.userTrackingMode=BMKUserTrackingModeFollowWithHeading;
    map.showsUserLocation=YES;
    map.zoomEnabledWithTap=YES;
    map.zoomEnabled=YES;
//    map.minZoomLevel=5;
//    map.maxZoomLevel=20;
    map.zoomLevel=15;
    [self.view addSubview:map];
    [self locationUser];
}
-(void)locationUser
{
    locationService=[[BMKLocationService alloc]init];
    locationService.delegate=self;
    [locationService startUserLocationService];
}

#pragma mark==BMKLocationServiceDelegate
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [map updateLocationData:userLocation];
    currLocation=userLocation.location.coordinate;

//    [map setCenterCoordinate:userLocation.location.coordinate animated:YES];
}
#pragma mark==MyTableViewControllerDelegate
-(void)myTableViewSelectedRow:(NSIndexPath *)index table:(MyTableViewController *)table
{
    
    if (table.tag==100) {
        if (map.overlays.count>0) {
            [map removeOverlays:map.overlays];
        }
        BMKPoiSearch *search=[[BMKPoiSearch alloc]init];
        search.delegate=self;
        BMKNearbySearchOption *option=[[BMKNearbySearchOption alloc]init];
        option.location=currLocation;
        option.radius=5000;
        option.keyword=leftArray[index.row];
        ;
        NSLog(@"%@",[search poiSearchNearBy:option]?@"搜索成功":@"搜索失败");
        
    }
    if (table.tag==101) {
       routeSearch=[[BMKRouteSearch alloc]init];
        routeSearch.delegate=self;
        switch (index.row) {
            case 0:
                //步行
                self.routeSeachMode=WalkingMode;
                break;
            case 1:
                //公交
                self.routeSeachMode=TransitMode;
                break;
            case 2:
                //驾车
                self.routeSeachMode=DrivingMode;
                break;
            case 3:
                //骑行
                self.routeSeachMode=RidingMode;
                break;
            default:
                break;
        }
        
        
    }
}
#pragma mark==BMKPoiSearchDelegate
-(void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    if (map.annotations.count >0) {
        [map removeAnnotations:map.annotations];
    }
    [poiResult.poiInfoList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BMKPoiInfo *info=obj;
        BMKPointAnnotation *pointAnnotation=[[BMKPointAnnotation alloc]init];
        pointAnnotation.coordinate=info.pt;
        pointAnnotation.title=[NSString stringWithFormat:@"%@-%@",info.city,info.address];
        pointAnnotation.subtitle=info.address;
        [map addAnnotation:pointAnnotation];
    }];
    
}
#pragma mark==BMKMapViewDelegate
-(BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *anView=(BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"an"];
        if (!anView) {
            anView=[[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"an"];
            
        }
        anView.pinColor=BMKPinAnnotationColorGreen;
        anView.animatesDrop=YES;
        return anView;
    }
    return nil;
}
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    selectedAnnotationView=view;
    if (map.overlays.count >0) {
        [map removeOverlays:map.overlays];
    }
    
}
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *lineView=[[BMKPolylineView alloc]initWithOverlay:overlay];
        switch (_routeSeachMode) {
            case WalkingMode:
                lineView.strokeColor=[UIColor purpleColor];

                break;
            case TransitMode:
                lineView.strokeColor=[UIColor greenColor];
                
                break;

            case DrivingMode:
                lineView.strokeColor=[UIColor magentaColor];
                
                break;

            case RidingMode:
                lineView.strokeColor=[UIColor redColor];
                
                break;

                
            default:
                break;
        }
        
        lineView.lineWidth=4.0;
        return lineView;
    }
    return nil;
}

#pragma mark==重写枚举方法
-(void)setRouteSeachMode:(RouteSearchMode)routeSeachMode
{
    _routeSeachMode=routeSeachMode;
    switch (_routeSeachMode) {
        case WalkingMode:{
            BMKPlanNode *from=[[BMKPlanNode alloc]init];
            from.pt=currLocation;
            BMKPlanNode *to=[[BMKPlanNode alloc]init];
            to.pt=selectedAnnotationView.annotation.coordinate;
            BMKWalkingRoutePlanOption *walkingOp=[[BMKWalkingRoutePlanOption alloc]init];
            walkingOp.from=from;
            walkingOp.to=to;
            NSLog(@"%@",[routeSearch walkingSearch:walkingOp]?@"成功":@"失败");
        }
            break;
        case TransitMode:
        {
            BMKPlanNode *from=[[BMKPlanNode alloc]init];
            from.pt=currLocation;
            BMKPlanNode *to=[[BMKPlanNode alloc]init];
             to.pt=selectedAnnotationView.annotation.coordinate;
            BMKTransitRoutePlanOption *transitOp=[[BMKTransitRoutePlanOption alloc]init];
            transitOp.from=from;
            transitOp.to=to;
            transitOp.city=[selectedAnnotationView.annotation.subtitle componentsSeparatedByString:@"-"][0];
            NSLog(@"%@",[routeSearch transitSearch:transitOp]?@"成功":@"失败");
        }
            break;
        case DrivingMode:
        {
            BMKPlanNode *from=[[BMKPlanNode alloc]init];
            from.pt=currLocation;
            BMKPlanNode *to=[[BMKPlanNode alloc]init];
            to.pt=selectedAnnotationView.annotation.coordinate;
            BMKDrivingRoutePlanOption *drivingOp=[[BMKDrivingRoutePlanOption alloc]init];
            drivingOp.from=from;
            drivingOp.to=to;
            NSLog(@"%@",[routeSearch drivingSearch:drivingOp]?@"成功":@"失败");
        }
            break;
        case RidingMode:
        {
            BMKPlanNode *from=[[BMKPlanNode alloc]init];
            from.pt=currLocation;
            BMKPlanNode *to=[[BMKPlanNode alloc]init];
            to.pt=selectedAnnotationView.annotation.coordinate;
            BMKRidingRoutePlanOption *ridingOp=[[BMKRidingRoutePlanOption alloc]init];
            ridingOp.from=from;
            ridingOp.to=to;
            NSLog(@"%@",[routeSearch ridingSearch:ridingOp]?@"成功":@"失败");
        }            break;
            
        default:
            break;
    }
}
#pragma mark==BMKRouteSearchDelegate
-(void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
//    if (map.overlays.count>0) {
//        [map removeOverlays:map.overlays];
//    }
    BMKWalkingRouteLine *line=[result.routes lastObject];
    for (int i=0; i<line.steps.count; i++) {
        BMKWalkingStep *step=line.steps[i];
        [self routeLineWithWalkingStep:step];
    }
    
}
-(void)onGetTransitRouteResult:(BMKRouteSearch *)searcher result:(BMKTransitRouteResult *)result errorCode:(BMKSearchErrorCode)error
{

//    if (map.overlays.count>0) {
//        [map removeOverlays:map.overlays];
//    }
    [result.routes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BMKTransitRouteLine *line=obj;
        for (int i=0; i<line.steps.count; i++) {
            BMKTransitStep *step=line.steps[i];
            [self routeLineWithTransitStep:step];
        }

    }];
    
}
-(void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
//    if (map.overlays.count>0) {
//        [map removeOverlays:map.overlays];
//    }
    [result.routes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BMKDrivingRouteLine *line=obj;
        for (int i=0; i<line.steps.count; i++) {
            BMKDrivingStep *step=line.steps[i];
            [self routeLineWithDrivingStep:step];
        }
        
    }];

}
-(void)onGetRidingRouteResult:(BMKRouteSearch *)searcher result:(BMKRidingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
//    if (map.overlays.count>0) {
//        [map removeOverlays:map.overlays];
//    }
    [result.routes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BMKRidingRouteLine *line=obj;
        for (int i=0; i<line.steps.count; i++) {
            BMKRidingStep *step=line.steps[i];
            [self routeLineWithRidingStep:step];
        }
        
    }];
}
-(void)routeLineWithWalkingStep:(BMKWalkingStep *)step
{
    CLLocationCoordinate2D coods[2]={0};
    coods[0]=step.entrace.location;
    coods[1]=step.exit.location;
    BMKPolyline *polyLine=[BMKPolyline polylineWithCoordinates:coods count:2];
    [map addOverlay:polyLine];
}
-(void)routeLineWithDrivingStep:(BMKDrivingStep *)step
{
    CLLocationCoordinate2D coods[2]={0};
    coods[0]=step.entrace.location;
    coods[1]=step.exit.location;
    BMKPolyline *polyLine=[BMKPolyline polylineWithCoordinates:coods count:2];
    [map addOverlay:polyLine];
}
-(void)routeLineWithTransitStep:(BMKTransitStep *)step
{
    CLLocationCoordinate2D coods[2]={0};
    coods[0]=step.entrace.location;
    coods[1]=step.exit.location;
    BMKPolyline *polyLine=[BMKPolyline polylineWithCoordinates:coods count:2];
    [map addOverlay:polyLine];
}
-(void)routeLineWithRidingStep:(BMKRidingStep *)step
{
    CLLocationCoordinate2D coods[2]={0};
    coods[0]=step.entrace.location;
    coods[1]=step.exit.location;
    BMKPolyline *polyLine=[BMKPolyline polylineWithCoordinates:coods count:2];
    [map addOverlay:polyLine];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
