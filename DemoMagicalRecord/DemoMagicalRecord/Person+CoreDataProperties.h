//
//  Person+CoreDataProperties.h
//  DemoMagicalRecord
//
//  Created by zj－db0465 on 16/1/15.
//  Copyright © 2016年 icetime17. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *firstname;
@property (nullable, nonatomic, retain) NSString *lastname;

@end

NS_ASSUME_NONNULL_END
