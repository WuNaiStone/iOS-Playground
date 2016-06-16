//
//  PersonRealm.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <Realm/Realm.h>

@interface PersonRealm : RLMObject

@property NSString *name;
@property NSInteger age;
@property NSString *city;
@property NSString *job;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<PersonRealm>
RLM_ARRAY_TYPE(PersonRealm)
