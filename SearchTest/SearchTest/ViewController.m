//
//  ViewController.m
//  SearchTest=============搜索==模糊查询
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@end

@implementation ViewController
{
    NSArray *tableArray;
    UISearchController *search;
    NSArray *arrayAge;
    
    
}
/*
 UISearchBar==iOS8之前使用==UISearchDisplayController
 PS:"UISearchDisplayController has been replaced with UISearchController"
 搜索一般与表相结合使用
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
-(void)initUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    tableArray=@[@"450056",@"45hfg56",@"45thuyrt56",@"4545454556",@"45798898956",@"45523236",@"4578978956",@"45787956",@"45232356",@"455695666",@"4578956",@"412232556",@"451556",@"4456564556",@"4564h56f556",@"45556456",@"4556656",@"457898978956"];
    arrayAge=tableArray;//记录一下tableView原来的数组
    self.myTableView.delegate=self;
    self.myTableView.dataSource=self;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    
    search=[[UISearchController alloc]initWithSearchResultsController:nil];//PS：必须用这个初始化方法initWithSearchResultsController，不然搜索框不会出现并且模态弹出UISearchController会崩！！！！
 search.searchBar.scopeButtonTitles=@[@"1212",@"1214251"];//在搜索框下展示SegmentedControl
    
    search.searchBar.showsSearchResultsButton=YES;
    search.searchBar.placeholder=@"请输入搜索内容";
    
    search.searchBar.frame=CGRectMake(0, 0, SCREENWIDTH, 44);
    self.myTableView.tableHeaderView=search.searchBar;
    
    search.delegate=self;//设置代理方法
    search.searchResultsUpdater=self;//设置搜索结果更新代理
    
//    [self presentViewController:search animated:YES completion:nil];//可以不模态弹出，直接将UISearchController中的searchBar加入到表头，而且这里用模态也没有动画效果
    
}
#pragma mask==UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text=tableArray[indexPath.row];
    return cell;
}
#pragma mask==UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"将要弹出");
}
- (void)didPresentSearchController:(UISearchController *)searchController{
    NSLog(@"已经弹出");

}
- (void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"将要消失");
}
- (void)didDismissSearchController:(UISearchController *)searchController{
    NSLog(@"已经消失");
}

#pragma mask==UISearchResultsUpdating
#pragma mask==模糊查询

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//更新搜索结果===输入框的值发生变化的时候调用
    NSString *searchContent= search.searchBar.text;//获取输入框中的内容
    NSLog(@"更新搜索结果，输入搜索框的内容：%@",searchContent);
    NSMutableArray *array=[[NSMutableArray alloc]init];
    
    NSLog(@"%@",arrayAge);
    if (searchContent.length>0)
    {//输入框不为空的时候
    for (NSString *str in arrayAge)//必须遍历记录的数组，因为tableView用的数组是变化的
    {
        //模糊查询的核心
        
            NSRange range=[str rangeOfString:searchContent];//发现数据中有输入的内容
            
            if (range.length>0)
            {
                NSLog(@"有结果！");
                [array addObject:str];
            }
        tableArray=array;
        [self.myTableView reloadData];
    }
    }else{//输入框为空的时
        tableArray=arrayAge;
        [self.myTableView reloadData];
    }
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
