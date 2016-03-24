//
//  People+CoreDataProperties.h
//  CoreDataTestOneToMany
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 Seven. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "People.h"

NS_ASSUME_NONNULL_BEGIN

@interface People (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, retain) NSSet<Car *> *cars;

@end

@interface People (CoreDataGeneratedAccessors)

- (void)addCarsObject:(Car *)value;
- (void)removeCarsObject:(Car *)value;
- (void)addCars:(NSSet<Car *> *)values;
- (void)removeCars:(NSSet<Car *> *)values;

@end

NS_ASSUME_NONNULL_END
