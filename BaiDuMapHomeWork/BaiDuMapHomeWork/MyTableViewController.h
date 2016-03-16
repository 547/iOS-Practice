//
//  MyTableViewController.h
//  BaiDuMapHomeWork
//
//  Created by mac on 16/3/16.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyTableViewControllerDelegate;
@interface MyTableViewController : UITableViewController
@property(nonatomic,unsafe_unretained)int tag;
@property (nonatomic,strong)NSArray *tableArray;
@property(nonatomic,unsafe_unretained)id<MyTableViewControllerDelegate>delegate;
@end
@protocol MyTableViewControllerDelegate <NSObject>

-(void)myTableViewSelectedRow:(NSIndexPath *)index table:(MyTableViewController *)table;

@end