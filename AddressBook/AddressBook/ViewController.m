//
//  ViewController.m
//  AddressBook
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//
/**
 跟着官方的Demo写的通讯录
 
 **/
#import <AddressBook/AddressBook.h>
#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)ABAddressBookRef *addressBook;
@property(nonatomic,strong)NSMutableArray *sourcesAndGroups;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建一个通讯录对象
    _addressBook=ABAddressBookCreateWithOptions(NULL, NULL);
    //创建一个装所有数据的数据
    _sourcesAndGroups=[[NSMutableArray alloc]initWithCapacity:0];
    
    
    
}

-(void)checkAddressBookAccess
{
    //ABAddressBookGetAuthorizationStatus==获取进入的授权的状态
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
            //已经授权
            [self accessGrantedAddressBook];
            break;
        case kABAuthorizationStatusDenied:
            //拒绝
        {
            UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"不进入通讯录界面" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alter show];
        
        }
            break;
        case kABAuthorizationStatusNotDetermined:
            //用户还没来得及给出答案
            [self requestAddressBookAccess];
            break;
        default:
            break;
    }
}
//请求进入通讯录
-(void)requestAddressBookAccess
{
ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
    if (granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self accessGrantedAddressBook];
        });
    }
});
}
//已经进入通讯录
-(void)accessGrantedAddressBook
{

}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
