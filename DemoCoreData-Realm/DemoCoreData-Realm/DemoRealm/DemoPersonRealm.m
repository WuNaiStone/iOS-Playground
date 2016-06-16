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
    
    RLMRealm *realm         = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:aPerson];
    }];
}

- (NSArray *)queryPersonRealm {
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:0];
    
    RLMResults *persons = [PersonRealm allObjects];
    for (PersonRealm *p in persons) {
        NSLog(@"p : %@", p.description);
        [results addObject:p];
    }
    
    return results;
}


@end
