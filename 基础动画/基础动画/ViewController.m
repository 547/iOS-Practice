//
//  ViewController.m
//  基础动画
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    int tag;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI
{
    tag=1;
    self.mainImage.image=[UIImage imageNamed:@"1.png"];
}
//切换图片
- (IBAction)qieHuanTuPian:(UIButton *)sender {
    tag+=1;
    if (tag==4) {
        tag=1;
    }
    [self setImage:tag];
}

-(void)setImage:(int)tagB
{
    CATransition *tr=[[CATransition alloc]init];
    
/*
 
 setType:有四种类型：
 
 
 
 kCATransitionFade                   //交叉淡化过渡
 
 kCATransitionMoveIn               //移动覆盖原图
 
 kCATransitionPush                    //新视图将旧视图推出去
 
 kCATransitionReveal                //底部显出来
 
 另一种设置方法
 
 pageCurl     //向上翻一页
 
 pageUnCurl   //向下翻一页
 
 rippleEffect   //滴水效果
 
 suckEffect     //收缩效果，如一块布被抽走
 
 cube       //立方体效果
 
 oglFlip      //上下翻转效果

 */
    /*
     CATransition相关属性
     
     endProgress
     @property float endProgress
     定义过渡的结束点
     结束点的值必须大于或者等于开始点。
     默认值为1.0。
     
     startProgress
     @property float startProgress
     
     定义过度的开始点
     开始点的值必须小于或者等于结束点。
     默认值为0.0。
     
     这两个属性是float类型的。
     可以控制动画进行的过程，可以让动画停留在某个动画点上，值在0.0到1.0之间。endProgress要大于等于startProgress。
     比如:立方体转，可以设置endProgress= 0.5，让动画停留在整个动画的特定位置(停止在旋转一般的状态)。
     
     filter
     @property(retain) CIFilter *filter
     
     为动画添加一个可选的滤镜。
     如果指定，那么指定的filter必须同时支持x和y，否则该filter将不起作用。
     默认值为nil。
     如果设置了filter，那么，为layer设置的type和subtype属性将被忽略。
     该属性只在iOS 5.0以及以后版本被支持。
     
     subtype
     @property(copy) NSString *subtype
     指定预定义的过渡方向。
     默认为nil。
     如果指定了filter，那么该属性无效。
     
     预定义的过渡方向为：
     NSString * const kCATransitionFromRight;
     NSString * const kCATransitionFromLeft;
     NSString * const kCATransitionFromTop;
     NSString * const kCATransitionFromBottom;
     分别表示：过渡从右边、左边、顶部、底部 开始。
     
     type
     @property(copy) NSString *type
     
     指定预定义的过渡效果。
     默认为kCATransitionFade
     如果指定了filter，那么该属性无效。
     
     预定义的过渡效果：
     NSString * const kCATransitionFade;
     NSString * const kCATransitionMoveIn;
     NSString * const kCATransitionPush;
     NSString * const kCATransitionReveal;
     
     分别表示：淡出、覆盖原图、推出、从底部显示。
     
     注意：
     还有很多私有API效果，使用的时候要小心，可能会导致app审核不被通过（悲剧啊，为啥有却不让用啊！好东西不应该被束之高阁！）：
     
     fade     //交叉淡化过渡(不支持过渡方向)
     push     //新视图把旧视图推出去
     moveIn   //新视图移到旧视图上面
     reveal   //将旧视图移开,显示下面的新视图
     cube     //立方体翻滚效果
     oglFlip  //上下左右翻转效果
     suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
     rippleEffect //滴水效果(不支持过渡方向)
     pageCurl     //向上翻页效果
     pageUnCurl   //向下翻页效果
     cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
     cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
     */

    tr.duration=2.0;
    tr.type=@"rippleEffect";

    [self.mainImage.layer addAnimation:tr forKey:kCATransitionFade];
    self.mainImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",tagB]];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
