//
//  ViewController.m
//  PuBuLiuTest====瀑布流的实现:核心就是自定义FlowLayout
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "MyLayout.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController
{
    NSArray *heightArray;//高度数组
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}
//将来服务器返回的都是对应的图片高度
-(void)initUI
{
    heightArray=@[@(90),@(130),@(80),@(50),@(110),@(50),@(85),@(42),@(120),@(94),@(65),@(78),@(112),@(78),@(45),@(230),@(96),@(39),@(89),@(70),@(80)];
    
    /*
     三步展现两列瀑布流
     1.创建MyLayout（自定义的）的对象
     2.传递单元格高度的数组
     3.设置瀑布流与屏幕边界的宽度
     */
    MyLayout *la=[[MyLayout alloc]init];//初始化自定义Layout
    la.heightArray=heightArray;//设置单元的高度数组
    la.marginToScreen=5.0;//设置瀑布流与屏幕边界的宽度
    
    
    //系统的UICollectionView和UICollectionViewCell
    self.myCollectionView.backgroundColor=[UIColor whiteColor];
    [self.myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.myCollectionView setCollectionViewLayout:la];
    self.myCollectionView.delegate=self;
    self.myCollectionView.dataSource=self;
}

#pragma mask==UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return heightArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor=[UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:arc4random()%10*0.1];//随机设置单元的背景颜色

    return cell;
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
