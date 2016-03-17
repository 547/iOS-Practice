//
//  SWBluetoothTool.m
//  CoreBluetoothTest
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SWBluetoothTool.h"
//这是一个单例类
@implementation SWBluetoothTool
{
    BOOL pendingInit;
    CBCentralManager *centralManager;
    NSMutableArray *foundPeripherals;//发现的设备
    NSMutableArray *connectedServices;//已经连接的设备
}
#pragma mark==初始化
+(id)sharedBlueToothTool
{
    static SWBluetoothTool *bluetooth=nil;
    if (!bluetooth) {
        bluetooth=[[SWBluetoothTool alloc]init];
    }
    return bluetooth;
}
-(id)init
{
    self=[super init];
    if (self) {//初始化本类的属性
        pendingInit=YES;
        foundPeripherals=[[NSMutableArray alloc]init];
        connectedServices=[[NSMutableArray alloc]init];
        centralManager=[[CBCentralManager alloc]initWithDelegate:self queue:dispatch_get_main_queue()];//建立中心角色
    }
    return self;
}
#pragma mark==设置
//加载已经保存过的设备
-(void)loadSavedDevices
{

}
//添加已经保存的设备
-(void)addSavedDevices
{

}
//移除已经保存的设备
-(void)removeSavedDevices
{

}
#pragma mark==搜索周边开启蓝牙的设备
//通过uuid扫描开启蓝牙的设备
-(void)startScanningForUUIDString
{
    NSDictionary *options=[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:CBCentralManagerScanOptionAllowDuplicatesKey];
    
    [centralManager scanForPeripheralsWithServices:nil options:options];
}
//停止扫描
-(void)stopScanning
{
    [centralManager stopScan];
}
#pragma mark==CBCentralManagerDelegate
//已经发现外围设备
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    //判断找到的外围设备数组中是否已经存在当前查找的设备
    if (![foundPeripherals containsObject:peripheral]) {
        //如果没有才添加到数组里面
        [foundPeripherals addObject:peripheral];//在找到的外围设备数组中添加找到的外围设备
    }
    
}
#pragma mark==发现的外围设备的连接业务
//不连接某一设备
-(void)disconnetPeripheral:(CBPeripheral *)peripheral
{
    [centralManager cancelPeripheralConnection:peripheral];
}
//连接某一设备
-(void)connetPeripheral:(CBPeripheral *)peripheral
{
    [centralManager connectPeripheral:peripheral options:nil];
}
#pragma mark==CBCentralManagerDelegate
//连接失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (error) {
        NSLog(@"连接失败：%@",error);
    }
}
//已经连接到某一设备
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{

    peripheral.delegate=self;
    
    [peripheral discoverServices:nil];
    
}
#pragma mark==CBPeripheralDelegate
//发现服务
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error) {
        NSLog(@"发现服务出错：%@",error);
        return;
    }
    for (CBService *service in peripheral.services) {
        //发现服务
        if ([service.UUID isEqual:[CBUUID UUIDWithString:_uuidString]]) {
//            peripheral discoverCharacteristics:<#(nullable NSArray<CBUUID *> *)#> forService:<#(nonnull CBService *)#>
        }
    }
}
//因为服务中发现特征
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{

}
@end
