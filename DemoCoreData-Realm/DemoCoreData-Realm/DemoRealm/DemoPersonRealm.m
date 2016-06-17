//
//  DemoPersonRealm.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonRealm.h"
#import "PersonRealm.h"

@implementation DemoPersonRealm

+ (instancetype)sharedInstance {
    static DemoPersonRealm *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (void)addPersonRealm {
    RLMResults *persons     = [PersonRealm allObjects];
    
    NSInteger index         = persons.count + 1;
    
    PersonRealm *aPerson    = [[PersonRealm alloc] init];
    aPerson.name            = [NSString stringWithFormat:@"name %ld", index];
    aPerson.age             = index;
    aPerson.city            = [NSString stringWithFormat:@"city %ld", index];
    aPerson.job             = [NSString stringWithFormat:@"job %ld", index];
    aPerson.email           = [NSString stringWithFormat:@"email %ld", index];
    aPerson.wechatId        = [NSString stringWithFormat:@"wechatId %ld", index];
    aPerson.avatar          = index % 2 ? @"avatar1.png" : @"avatar2.png";
    aPerson.height          = 170 + index % 10;
    aPerson.weight          = 60 + index % 10;
    
    RLMRealm *realm         = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:aPerson];
    }];
}

- (NSArray *)queryPersonRealm {
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
    
    RLMResults *persons = [PersonRealm allObjects];
    for (PersonRealm *p in persons) {
//        NSLog(@"p : %@", p.description);
        [results addObject:p];
    }
    
    RLMRealm *realm         = [RLMRealm defaultRealm];
    
    NSLog(@"fileURL : %@", realm.configuration.fileURL);
    
    return results;
}


@end
