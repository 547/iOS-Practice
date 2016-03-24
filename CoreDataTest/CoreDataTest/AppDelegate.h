//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



/**下面这些属性和方法core data帮我们生成的属性和方法
 
 */
/**关联上下文（提供oc和数据库之间的转化*/
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/**数据模型*/
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/**持久化存储协调器-==管理数据库的文件*/
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

/***/
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

