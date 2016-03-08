//
//  TestViewController.h
//  模仿Android写父类ViewControll
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "SuperViewController.h"

@interface TestViewController : SuperViewController
/*
 TestViewController继承于SuperViewController（自己写的写继承于UIViewController的类），在SuperViewController中写了TouchBegian方法，并在该方法里实现了[self.view endEditing:YES]。
 TestViewController继承于SuperViewController也会执行TouchBegian里面的方法，点击TextFeild外面的时候虚拟键盘会收起来
 
 所以以后开发的时候，如果页面有通用特性的时候可以，自定义一个父类让其继承，可以减少代码
 
 
 */
@end
