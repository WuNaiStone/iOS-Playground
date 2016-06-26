//
//  PersonCoreData+CoreDataProperties.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/17.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonCoreData.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonCoreData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;
@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *job;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *wechatId;
@property (nullable, nonatomic, retain) NSString *avatar;
@property (nullable, nonatomic, retain) NSNumber *height;
@property (nullable, nonatomic, retain) NSNumber *weight;

@end

NS_ASSUME_NONNULL_END
