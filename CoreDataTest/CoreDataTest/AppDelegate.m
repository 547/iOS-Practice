//
//  AppDelegate.m
//  CoreDataTest
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "AppDelegate.h"
#import "People.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //崩溃程序的方法==指示当前程序终止==苹果私有API
//    abort();
//    exit(0);//退出==苹果私有API
    
#pragma mark==向数据库中插入数据
    /*
     插入当前列表中的实例对象
     insertNewObjectForEntityForName
     参数1.列表中的实例的名字==相当于表名
     参数2.把读取出来的实例交给context管理
     */
    People *peo=[NSEntityDescription insertNewObjectForEntityForName:@"People" inManagedObjectContext:self.managedObjectContext];
    peo.name=@"hhh";
    peo.age=222;
    //操作完成之后通过调用当前的保存方法来更新数据库
    [self saveContext];
    
#pragma mark==查看数据库中的数据
    /**
     查看数据库
     */
//    NSFetchRequest *fetch=[NSFetchRequest fetchRequestWithEntityName:@"People"];
//    //找到当前数据库的所有内容，根据索引
//   NSArray *peoples= [self.managedObjectContext executeFetchRequest:fetch error:nil];
//    NSLog(@"====%@",peoples);
 
#pragma mark==删除某条数据
    /**
     删除某条数据
     */
    // 1. 实例化查询请求
//    NSFetchRequest *fet=[NSFetchRequest fetchRequestWithEntityName:@"People"];
//    
//    // 2. 设置谓词条件
//    NSPredicate *pre=[NSPredicate predicateWithFormat:@"self.name='hhh'"];
//    [fet setPredicate:pre];
//    
//    // 3. 由上下文查询数据
//   NSArray *result = [self.managedObjectContext executeFetchRequest:fet error:nil];
//
//     // 4. 输出结果
//    for (People *p in result) {
//        NSLog(@"====%@",p.name);
//        // 删除一条记录
//        [self.managedObjectContext deleteObject:p];
//        
//    }
//     // 5. 通知_context保存数据
//    [self saveContext];//增、删、改数据一定要保存，其实就是重新提交新的结果集
    
#pragma mark==修改某条数据
    /**
     修改某条数据
     */
    // 1. 实例化查询请求
    NSFetchRequest *fet=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    // 2. 设置谓词条件
    fet.predicate=[NSPredicate predicateWithFormat:@"name='hhh'"];
      // 3. 由上下文查询数据
    NSArray *result=[self.managedObjectContext executeFetchRequest:fet error:nil];
    // 4. 输出结果
    for (People *p in result) {
        NSLog(@"===%@",p.name);
        //修改数据
        p.name=@"123";
        p.age=2222;
    }
    // 5. 保存数据
    [self saveContext];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.SevenDream.CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //momd是coredata的编译格式其实就是CoreDataTest.xcdatamodeld
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataTest" withExtension:@"momd"];
    NSLog(@"modelURL==%@",modelURL.absoluteString);
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    NSLog(@"storeURL==%@",storeURL.absoluteString);//保存在Documents文件夹下
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
             //崩溃程序的方法==指示当前程序终止==苹果私有API
            abort();
        }
    }
}

@end
