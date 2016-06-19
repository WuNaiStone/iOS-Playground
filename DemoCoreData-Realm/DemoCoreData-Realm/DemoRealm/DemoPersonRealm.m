//
//  DemoPersonRealm.m
//  DemoCoreData-Realm
//
//  Created by Chris Hu on 16/6/16.
//  Copyright © 2016年 com.icetime17. All rights reserved.
//

#import "DemoPersonRealm.h"

@interface DemoPersonRealm ()

@property (nonatomic, strong) RLMNotificationToken *notificationTokenRealm;

@property (nonatomic, strong) RLMNotificationToken *notificationTokenRealmCollection;

@end

@implementation DemoPersonRealm

+ (instancetype)sharedInstance {
    static DemoPersonRealm *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
        
        // Realm Notification
        [sharedInstance addRealmNotifications];
    });
    
    return sharedInstance;
}

- (void)addRealmNotifications {
    // Realm Notification
    RLMRealm *realm         = [RLMRealm defaultRealm];
    _notificationTokenRealm = [realm addNotificationBlock:^(NSString * _Nonnull notification, RLMRealm * _Nonnull realm) {
        NSLog(@"Realm Write Notification : %@, %@", notification, realm);
        
        if (_delegateUpdated && [_delegateUpdated respondsToSelector:@selector(DemoPersonRealmUpdated)]) {
            [_delegateUpdated DemoPersonRealmUpdated];
        }
    }];
    
    
    // Collection Notification
    _notificationTokenRealmCollection = [[PersonRealm objectsWhere:@"age == 18"] addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
        NSLog(@"Realm Collection Notification : %@, %@", results, change);
    }];
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

- (void)deletePersonRealm {
    RLMResults *persons = [PersonRealm objectsWhere:@"age == 18"];
    
    RLMRealm *realm         = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:[persons firstObject]];
        
//        [realm deleteObjects:persons];
        
//        [realm deleteAllObjects];
    }];
}

- (void)updatePersonRealm {
    RLMResults *persons = [PersonRealm objectsWhere:@"age == 18"];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [[persons firstObject] setValue:@20 forKey:@"age"];
        
//        [persons setValue:@20 forKey:@"age"];
    }];
}

- (RLMResults *)queryPersonRealm {
    RLMRealm *realm     = [RLMRealm defaultRealm];
    
    NSLog(@"fileURL : %@", realm.configuration.fileURL);
    
    RLMResults *persons = [PersonRealm allObjects];
    
    return persons;
}

- (RLMResults *)queryPersonRealmSortedBy:(NSString *)sortedProperty {
    RLMResults *persons = [[PersonRealm allObjects] sortedResultsUsingProperty:sortedProperty ascending:YES];
    
    return persons;
}

- (RLMResults *)queryPersonRealmFilteredBy:(NSString *)filterCondition {
    RLMResults *persons = [PersonRealm objectsWhere:filterCondition];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age == %d AND name BEGINSWITH %@", 18, @"C"];
//    RLMResults *persons = [PersonRealm objectsWithPredicate:predicate];
    
    return persons;
}

@end
