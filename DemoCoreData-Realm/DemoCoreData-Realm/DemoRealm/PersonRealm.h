//
//  PersonRealm.h
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <Realm/Realm.h>

// v0

@interface PersonRealm : RLMObject

@property NSString *name;
@property NSInteger age;
@property NSString *city;
@property NSString *job;
@property NSString *email;
@property NSString *wechatId;
@property NSString *avatar;
@property float height; // cm
@property float weight; // kg

@end

// This protocol enables typed collections. i.e.:
// RLMArray<PersonRealm>
RLM_ARRAY_TYPE(PersonRealm)




// v1
/*
@interface PersonRealm : RLMObject

@property NSString *name;
@property NSInteger age;
@property NSString *city;
@property NSString *job;
@property NSString *email;
@property NSString *wechatId;
@property NSString *avatar;
@property float height; // cm
@property float weight; // kg

// migration
@property BOOL isMarried;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<PersonRealm>
RLM_ARRAY_TYPE(PersonRealm)
*/



// v2
/*
@interface PersonRealm : RLMObject

@property NSString *name;
@property NSInteger age;
@property NSString *city;
@property NSString *job;
@property NSString *email;
@property NSString *wechatId;
@property NSString *avatar;
@property float height; // cm
@property float weight; // kg

// migration
@property BOOL isMarried;

@property NSString *nickname;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<PersonRealm>
RLM_ARRAY_TYPE(PersonRealm)
*/
