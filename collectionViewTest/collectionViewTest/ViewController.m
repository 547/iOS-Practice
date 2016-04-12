//
//  ViewController.m
//  collectionViewTest
//
//  Created by mac on 16/3/4.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initUI
{
    //块
    UICollectionViewFlowLayout *la=[[UICollectionViewFlowLayout alloc]init];
//设置对应的大小
    la.itemSize=CGSizeMake(60, 60);
    //区间距
    la.sectionInset=UIEdgeInsetsMake(10, 5, 0, 0);
    //行间距
    la.minimumInteritemSpacing=10;
    //初始化collectionView
    UICollectionView *coll=[[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:la];
    //注册单元格
    [coll registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    coll.delegate=self;
    coll.dataSource=self;
    [self.view addSubview:coll];
    

}
//
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //系统的cell没有三大特性：TextLabel、imageView、deti
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor redColor];
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
