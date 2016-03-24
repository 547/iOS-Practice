//
//  ViewController.m
//  CoreDataTestOneToMany
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "People.h"
#import "Car.h"
@interface ViewController ()

@end

@implementation ViewController
{
    AppDelegate *appdelegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self coreDataDeleteTest];
}

#pragma mark==添加数据
-(void)coreDataInsterTest
{
    //获取appdelegate
    appdelegate=[[UIApplication sharedApplication] delegate];
    //插入数据
    Car *car1=[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:appdelegate.managedObjectContext];
    car1.brand=@"qq";
    car1.price=50;
    Car *car2=[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:appdelegate.managedObjectContext];
    car2.brand=@"qq";
    car2.price=50;
    Car *car3=[NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:appdelegate.managedObjectContext];
    car3.brand=@"qq";
    car3.price=50;
    
    
    People *p=[NSEntityDescription insertNewObjectForEntityForName:@"People" inManagedObjectContext:appdelegate.managedObjectContext];
    p.name=@"1212";
    p.age=123;
    [p addCars:[NSSet setWithObjects:car1,car2,car3,nil]];
    [appdelegate saveContext];

}
#pragma mark==查询所有数据
-(void)coreDataQueryAllTest
{
    appdelegate=[UIApplication sharedApplication].delegate;
    NSFetchRequest *fet=[NSFetchRequest fetchRequestWithEntityName:@"Car"];
   NSArray *carResults= [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    for (Car *car in carResults) {
        NSLog(@"%@",car.brand);
    }
    
    NSFetchRequest *fetPeople=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    NSArray *peopleResults= [appdelegate.managedObjectContext executeFetchRequest:fetPeople error:nil];
    for (People *p in peopleResults) {
//        NSLog(@"p===%@",p.cars);
        for (Car *car in p.cars) {
            NSLog(@"====%@",car.brand);
        }
    }

}
#pragma mark==查询指定数据
-(void)coreDataQueryCarWithNameTest
{
    appdelegate=[UIApplication sharedApplication].delegate;
    NSFetchRequest *fet=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    fet.predicate=[NSPredicate predicateWithFormat:@"name='12'"];
   NSArray *results= [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    for (People *p in results) {
        for (Car *car in p.cars) {
            NSLog(@"===car==%@",car.brand);
        }
    }
}
#pragma mark==修改数据
-(void)coreDataAlterTest
{
    appdelegate=[UIApplication sharedApplication].delegate;
    NSFetchRequest *fet=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    fet.predicate=[NSPredicate predicateWithFormat:@"name='12'"];
  NSArray *results =  [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    for (People *p in results) {
        for (Car *car in p.cars) {
            car.brand=@"bmw";
        }
    }
    [appdelegate saveContext];
}
#pragma mark==修改数据
-(void)coreDataDeleteTest
{
    appdelegate=[UIApplication sharedApplication].delegate;
    NSFetchRequest *fet=[NSFetchRequest fetchRequestWithEntityName:@"People"];
    fet.predicate=[NSPredicate predicateWithFormat:@"name='12'"];
 NSArray *results = [appdelegate.managedObjectContext executeFetchRequest:fet error:nil];
    for (People *p in results) {
        for (Car *car in p.cars) {
            [appdelegate.managedObjectContext deleteObject:car];
        }
    }
    [appdelegate saveContext];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
