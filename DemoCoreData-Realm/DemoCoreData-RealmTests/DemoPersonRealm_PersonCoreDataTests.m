//
//  DemoPersonRealm_PersonCoreDataTests.m
//  DemoCoreData-Realm
//
//  Created by zj－db0465 on 16/6/20.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DemoPersonRealm.h"
#import "DemoPersonCoreData.h"
#import "AppDelegate.h"

@interface DemoPersonRealm_PersonCoreDataTests : XCTestCase

@end

@implementation DemoPersonRealm_PersonCoreDataTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPerformancePersonRealmAdd {
    [self measureBlock:^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm transactionWithBlock:^{
            for (NSInteger i = 0; i<100000; i++) {
                PersonRealm *person = [[PersonRealm alloc] init];
                person.name     = @"chris";
                person.age      = 18;
                person.city     = @"city 1";
                person.job      = @"job 1";
                person.email    = @"email 1";
                person.wechatId = @"wechatId 1";
                person.avatar   = @"avatar1.png";
                person.height   = 175;
                person.weight   = 65;
                [realm addObject:person];
            }
        }];
    }];
}

- (void)testPerformancePersonCoreDataAdd {
    [self measureBlock:^{
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSManagedObjectContext *_managedObjectContext = appDelegate.managedObjectContext;
        
        for (NSInteger i = 0; i<100000; i++) {
            PersonCoreData *person = (PersonCoreData *)[NSEntityDescription insertNewObjectForEntityForName:@"PersonCoreData" inManagedObjectContext:_managedObjectContext];
            
            person.name     = @"chris";
            person.age      = @18;
            person.city     = @"city 1";
            person.job      = @"job 1";
            person.email    = @"email 1";
            person.wechatId = @"wechatId 1";
            person.avatar   = @"avatar1.png";
            person.height   = @175;
            person.weight   = @65;
        }
        
        [_managedObjectContext save:nil];
    }];
}

- (void)testPerformancePersonRealmQuery {
    [self measureBlock:^{
        RLMResults *persons = [[DemoPersonRealm sharedInstance] queryPersonRealm];
        NSLog(@"Realm persons : %ld", (long)persons.count);
    }];
}

- (void)testPerformancePersonCoreDataQuery {
    [self measureBlock:^{
        NSArray *persons = [[DemoPersonCoreData sharedInstance] queryPersonCoreData];
        NSLog(@"CoreData persons : %ld", (long)persons.count);
    }];
}

@end
