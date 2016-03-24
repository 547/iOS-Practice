//
//  Car+CoreDataProperties.h
//  CoreDataTestOneToMany
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 Seven. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Car.h"

NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

@property (nonatomic) int16_t price;
@property (nullable, nonatomic, retain) NSString *brand;

@end

NS_ASSUME_NONNULL_END
