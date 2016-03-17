//
//  SWBluetoothTool.h
//  CoreBluetoothTest
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
@interface SWBluetoothTool : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
@property(nonatomic,copy)NSString *uuidString;
@end
