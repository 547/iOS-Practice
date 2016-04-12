//
//  ViewController.m
//  FallsWithCollectionViewTest====自己写的瀑布流
//
//  Created by mac on 16/3/2.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
//屏幕宽
#define WIDTHOFSCREEN [UIScreen mainScreen].bounds.size.width
#define HEIGHTSCREEN [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController
{
    NSArray *colorArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//   CGFloat width= [UIScreen mainScreen].bounds.size.height;
    colorArray=@[[UIColor redColor],[UIColor blueColor],[UIColor grayColor],[UIColor greenColor],[UIColor cyanColor],[UIColor magentaColor]];
    [self initUI];//初始化视图
}
//初始化视图
-(void)initUI
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];//创建流动布局对象
    flowLayout.minimumInteritemSpacing=0;//设置最小cell之间的距离
    flowLayout.minimumLineSpacing=0;//设置最小行间距
    flowLayout.sectionInset=UIEdgeInsetsMake(1, 0, 0, 0);
    /*
     UICollectionViewScrollDirectionVertical==纵向
     UICollectionViewScrollDirectionHorizontal==横向
     */
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;//设置布局方向==默认纵向滑动
    
    UICollectionView *collection=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 21, WIDTHOFSCREEN, HEIGHTSCREEN-21) collectionViewLayout:flowLayout];//创建一个UICollectionView对象
    
    collection.delegate=self;//设置代理
    collection.dataSource=self;//设置数据源
    
    //注册单元格
    [collection registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collection];//加入父视图中

}
#pragma mask==UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];//通过标识符到重用队列中查找重用cell
    cell.backgroundColor=[colorArray objectAtIndex:arc4random()%6];//随机获取颜色数组中的颜色
    cell.layer.borderColor=[[UIColor whiteColor]CGColor];
    cell.layer.masksToBounds=YES;
    cell.layer.borderWidth=1;
    return cell;
}

#pragma mask===UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTHOFSCREEN*1/3, (arc4random()%40)+100);
}
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
//}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
