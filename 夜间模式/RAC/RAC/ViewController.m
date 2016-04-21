//
//  ViewController.m
//  RAC
//
//  Created by mac on 16/4/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NextViewController.h"

@interface ViewController ()
{
    UIWindow * m_brightnessWindow;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *_button =[[UIButton alloc]init];
    _button.frame =CGRectMake(100, 100, 100, 30);
    [_button setBackgroundColor:[UIColor redColor]];
    [_button setTitle:@"按钮" forState:UIControlStateNormal];
    [[_button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"怎么会没用---%@",x);
    }];
   [self.view addSubview:_button];
    
    
    [self performSelectorOnMainThread:@selector(installBrightnessWindow) withObject:nil waitUntilDone:NO];
    
  UISlider * m_control = [[UISlider alloc] initWithFrame:CGRectMake(10, 10, 100, 32)];
    m_control.minimumValue = 0.3;   //
    m_control.maximumValue = 1.0;
    m_control.value = 1.0;
    [[m_control rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        UISlider *silder =x;
         m_brightnessWindow.alpha = 1.0 - silder.value;
    }];
    [self.view addSubview:m_control];
    

    
    UIButton *_button2 =[[UIButton alloc]init];
    _button2.frame =CGRectMake(100, 300, 100, 30);
    [_button2 setBackgroundColor:[UIColor redColor]];
    [_button2 setTitle:@"下个界面" forState:UIControlStateNormal];
    [[_button2 rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        NextViewController *vc =[[NextViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        
    }];
    [self.view addSubview:_button2];

    
    
    
    
}



-(void)installBrightnessWindow
{
    m_brightnessWindow = [[UIWindow alloc] initWithFrame:self.view.window.frame];
    m_brightnessWindow.windowLevel = UIWindowLevelStatusBar+1;
    m_brightnessWindow.userInteractionEnabled = NO;
    m_brightnessWindow.backgroundColor = [UIColor blackColor];
    m_brightnessWindow.alpha = 0.5;
    m_brightnessWindow.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
